//
//  AppDelegate.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        bindViewModel()
        changeColorStatusBar()
        setCurrentLanguage()
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

    private func bindViewModel() {
        guard let window = window else {
            return
        }
        let navi = AppNavigator(window: window)
        let useCase = AppUseCase()
        let vm = AppViewModel(useCase: useCase, navigator: navi)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = vm.transform(input)
        output.toLogin.drive().disposed(by: rx.disposeBag)
    }
    
    func changeColorStatusBar() {
        UIApplication.shared.isStatusBarHidden = false
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        UINavigationBar.appearance().barStyle = .black
        statusBar.backgroundColor = UIColor.black
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func setCurrentLanguage() {
        let currentLanguage = Locale.current.languageCode ?? "en"
        Localize.setCurrentLanguage(currentLanguage)
    }
}

