//
//  SignUpViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

private struct Constants {
    static let signupLabelText = "SignUpVC.label.signup".localized()
    static let emailTextFieldText = "SignUpVC.textfield.email".localized()
    static let passwordTextFieldText = "SignUpVC.textfield.password".localized()
    static let rePasswordTextFieldText = "SignUpVC.textfield.repassword".localized()
    static let signUpButtonText = "SignUpVC.button.continue".localized()
    static let completeSignUp = "SignUpVC.complete.signup".localized()
}

class SignUpViewController: UIViewController, BindableType {

    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var signupLabel: UILabel!
    @IBOutlet weak private var emailTextField: HoshiTextField!
    @IBOutlet weak private var passwordTextField: HoshiTextField!
    @IBOutlet weak private var rePasswordTextField: HoshiTextField!
    @IBOutlet weak private var signUpButton: UIButton!
    
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
        rePasswordTextField.text = ""
    }
    
    func bindViewModel() {
        let input = SignUpViewModel.Input(email: emailTextField.rx.text.orEmpty.asDriver(),
                                          password: passwordTextField.rx.text.orEmpty.asDriver(),
                                          rePassword: rePasswordTextField.rx.text.orEmpty.asDriver(),
                                          signup: signUpButton.rx.tap.asDriver(),
                                          back: backButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        
        output.back
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.enableButton
            .drive(enableButton)
            .disposed(by: rx.disposeBag)
        
        output.signup
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.checkValid
            .drive(checkValid)
            .disposed(by: rx.disposeBag)
    }
    
    private var enableButton: Binder<Bool> {
        return Binder(self, binding: { (vc, isEnableButton) in
            vc.signUpButton.isEnabled = isEnableButton
            vc.signUpButton.alpha = isEnableButton ? 1 : 0.5
        })
    }
    
    private var checkValid: Binder<(Bool, String)> {
        return Binder(self, binding: { (vc, data) in
            if !data.0 {
                vc.showNotification(message: data.1)
            }
        })
    }
}
