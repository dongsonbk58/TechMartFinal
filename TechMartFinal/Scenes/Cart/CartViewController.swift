//
//  CartViewController.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, BindableType {

    var viewModel: CartViewModel!
    var refreshData = PublishSubject<Void>()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshData.onNext(())
    }
    func configUI() {
        title = "Cart"
        cartTableView.do {
            $0.register(cellType: CartTableViewCell.self)
            $0.addSubview(self.refreshControl)
            $0.rowHeight = 100
        }
    }
    
    func bindViewModel() {
        let trigger = NotificationCenter.default.rx.notification(Notification.Name.changeTab)
            .map {
                $0.object as? TabBarItemType
            }
            .unwrap()
            .distinctUntilChanged()
            .filter { $0 == TabBarItemType.cart }
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = CartViewModel.Input(loadTrigger: trigger,
                                        reloadTrigger: refreshData.asDriverOnErrorJustComplete(),
                                        selectRepoTrigger: cartTableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.productList
            .drive(cartTableView.rx.items) { tableView, index, product in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: CartTableViewCell.self)
                    .then {
                        $0.configView(with: product)
                }
            }
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
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
            vc.cartTableView.reloadData()
            vc.refreshControl.endRefreshing()
        })
    }
}
extension CartViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}
