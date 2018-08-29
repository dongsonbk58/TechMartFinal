//
//  DetailProductionViewController.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

class DetailProductionViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productNameLabel: NSLayoutConstraint!
    @IBOutlet weak var productDetailLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    
    var viewModel: DetailProductionViewModel!
    
    func bindViewModel() {
    }
    
    func configView() {
        addToCartButton.do {
            $0.layer.cornerRadius = 2
        }
    }
}

extension DetailProductionViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.product
    
}
