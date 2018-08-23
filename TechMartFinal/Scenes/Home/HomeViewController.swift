//
//  HomeViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "asdasdasd"
        navigationItem.titleView = searchBar
      //   changeColorStatusBar()
//        navigationController?.navigationBar.barStyle = .default
    }
    func changeColorStatusBar() {
        UIApplication.shared.isStatusBarHidden = false
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        UINavigationBar.appearance().barStyle = .default
        statusBar.backgroundColor = UIColor.black
        statusBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
   
}
extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home
}
