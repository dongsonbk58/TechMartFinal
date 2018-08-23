//
//  ForgotViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

private struct Constant {
    static let textLabel = "ForgotPasswordVC.label.text".localized()
    static let textButton = "ForgotPasswordVC.button.title".localized()
    static let errorInvalidEmail = "SignUpVC.error.invalidEmail".localized()
    static let completeText = "ForgotPasswordVC.complete.text".localized()
    static let errorText = "ForgotPasswordVC.error.text".localized()
}

class ForgotPasswordViewController: UIViewController, BindableType {

    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var bacgroundLockView: UIView!
    @IBOutlet weak private var lockImageView: UIImageView!
    @IBOutlet weak private var emailTextFiled: UITextField!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var resetPasswordButon: UIButton!

    var viewModel: ForgotPasswordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLanguage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bacgroundLockView.setGradientForUIView(UIColor.gray, UIColor.white, UIColor.white, isCorner: false)
        lockImageBackgroundViewSetup()
    }
    
    func setupLanguage() {
        textLabel.text = Constant.textLabel
        resetPasswordButon.setTitle(Constant.textButton, for: .normal)
    }
    
    private func lockImageBackgroundViewSetup() {
        bacgroundLockView.border(width: 1, color: UIColor.white)
        bacgroundLockView.cornerRadius(corner: bacgroundLockView.frame.size.height / 2)
    }
    
    func bindViewModel() {
        let input = ForgotPasswordViewModel.Input(backButton: backButton.rx.tap.asDriver(),
                                                  resetPassword: resetPasswordButon.rx.tap.asDriver(),
                                                  email: emailTextFiled.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input)
        
        output.back
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.reset
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.enableButton
            .drive(enableButton)
            .disposed(by: rx.disposeBag)
        
        output.validEmail
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    private var enableButton: Binder<Bool> {
        return Binder(self, binding: { (vc, isEnableButton) in
            vc.resetPasswordButon.isEnabled = isEnableButton
            vc.resetPasswordButon.alpha = isEnableButton ? 1 : 0.5
        })
    }
}
