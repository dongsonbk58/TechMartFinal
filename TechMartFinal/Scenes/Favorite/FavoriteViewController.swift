//
//  FavoriteViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, BindableType {

    var viewModel: FavoriteViewModel!
    var loadTrigger = PublishSubject<Void>()
    var refreshData = PublishSubject<Void>()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshData.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTrigger.onNext(())
        configUI()
    }
    
    func configUI() {
        title = "Favorite"
        favoriteTableView.do {
            $0.addSubview(refreshControl)
            $0.rowHeight = 80
            $0.register(cellType: FavoriteTableViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = FavoriteViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                            selected: favoriteTableView.rx.itemSelected.asDriver(),
                                            reloadTrigger: refreshData.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.productList
            .drive(favoriteTableView.rx.items) { tableView, index, product in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: FavoriteTableViewCell.self)
                    .then {
                        $0.configUI(product: product)
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.refreshing
            .drive(refreshBinding)
            .disposed(by: rx.disposeBag)
        
        output.selectedProduct
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    private var refreshBinding: Binder<Void> {
        return Binder(self, binding: { vc, _ in
            vc.loadTrigger.onNext(())
            vc.refreshControl.endRefreshing()
        })
    }
}
extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}

