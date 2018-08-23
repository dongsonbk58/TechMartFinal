//
//  LoginViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

private struct Constant {
    static let emailLabel = "LoginVC.textField.username".localized()
    static let passwordLabel = "LoginVC.textField.password".localized()
    static let loginButtonTitle = "LoginVC.button.login".localized()
    static let signupButtonTitle = "LoginVC.button.signup".localized()
    static let fotgotPasswordTitle = "LoginVC.button.forgotPassword".localized()
}

class LoginViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signupButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var passwordTextField: HoshiTextField!
    @IBOutlet private weak var usernameTextField: HoshiTextField!

    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        setTitleForComponent()
    }
    
    func setTitleForComponent() {
        forgotPasswordButton.setTitle(Constant.fotgotPasswordTitle, for: .normal)
        signupButton.setTitle(Constant.signupButtonTitle, for: .normal)
        loginButton.setTitle(Constant.loginButtonTitle, for: .normal)
        usernameTextField.placeholder = Constant.emailLabel
        passwordTextField.placeholder = Constant.passwordLabel
    }

    func bindViewModel() {
        let input = LoginViewModel.Input(loginTrigger: loginButton.rx.tap.asDriver(),
                                         signupTrigger: signupButton.rx.tap.asDriver(),
                                         username: usernameTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver(),
                                         forgorPassword: forgotPasswordButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.enableButton
            .drive(enableLoginButton)
            .disposed(by: rx.disposeBag)
        
        output.isLogin
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.signUp
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.forgot
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    private var enableLoginButton: Binder<Bool> {
        return Binder(self, binding: { (vc, isEnableButton) in
            vc.loginButton.isEnabled = isEnableButton
            vc.loginButton.alpha = isEnableButton ? 1 : 0.5
        })
    }
}
extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.login
}
