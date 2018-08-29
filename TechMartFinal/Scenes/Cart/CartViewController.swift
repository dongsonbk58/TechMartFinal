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
    
    @IBOutlet private weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        title = "Cart"
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
        let input = CartViewModel.Input(loadTrigger: trigger)
        let output = viewModel.transform(input)
        
    }
}
extension CartViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}
