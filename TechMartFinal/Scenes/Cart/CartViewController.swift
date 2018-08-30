//
//  CartViewController.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, BindableType {
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var costCountLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    var viewModel: CartViewModel!
    var refreshData = PublishSubject<Void>()
    var decProduct = PublishSubject<IndexPath>()
    var incProduct = PublishSubject<IndexPath>()
    var removeProduct = PublishSubject<IndexPath>()
    var loadTrigger = PublishSubject<Void>()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshData.onNext(())
    }

    func configUI() {
        title = "Cart"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "CaviarDreams", size: 20)!]
        cartTableView.do {
            $0.register(cellType: CartTableViewCell.self)
            $0.addSubview(self.refreshControl)
            $0.rowHeight = 80
        }
        
        buyButton.do {
            $0.layer.cornerRadius = 5
            $0.layer
                .setGradientForUIView(UIColor.colorWithHexaCode("ed0000"),
                                      UIColor.colorWithHexaCode("f26726"),
                                      isCorner: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTrigger.onNext(())
    }
    
    func bindViewModel() {
        let input = CartViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                        reloadTrigger: refreshData.asDriverOnErrorJustComplete(),
                                        selectRepoTrigger: cartTableView.rx.itemSelected.asDriver(),
                                        decProduct: decProduct.asDriverOnErrorJustComplete(),
                                        incProduct: incProduct.asDriverOnErrorJustComplete(),
                                        removeProduct: removeProduct.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input)
        
        output.productList
            .drive(cartTableView.rx.items) { tableView, index, cart in
                return tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: CartTableViewCell.self)
                    .then {
                        $0.configView(with: cart )
                        $0.decProductAction = {
                            self.decProduct.onNext(IndexPath(item: index, section: 0))
                        }
                        $0.incProductAction = {
                            self.incProduct.onNext(IndexPath(item: index, section: 0))
                        }
                        $0.removeProductAction = {
                            self.removeProduct.onNext(IndexPath(item: index, section: 0))
                        }
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
        
        output.decProduct
            .drive(decProductBinding)
            .disposed(by: rx.disposeBag)
        
        output.incProduct
            .drive(decProductBinding)
            .disposed(by: rx.disposeBag)
        
        output.removeProduct
            .drive(decProductBinding)
            .disposed(by: rx.disposeBag)
    }
    
    private var refreshBinding: Binder<Void> {
        return Binder(self, binding: { vc, _ in
            vc.loadTrigger.onNext(())
            vc.refreshControl.endRefreshing()
        })
    }
    
    private var decProductBinding: Binder<Void> {
        return Binder(self, binding: { vc, _ in
           vc.loadTrigger.onNext(())
        })
    }
}
extension CartViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}
