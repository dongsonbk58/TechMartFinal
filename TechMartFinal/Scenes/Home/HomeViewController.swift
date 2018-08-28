//
//  HomeViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home
}
