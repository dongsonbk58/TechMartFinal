//
//  ProfileViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

private struct Constants {
    static let titleLabel = "ProfileVC.label.title".localized()
    static let errorMessage = "Profile.error.message".localized()
    static let completeMessate = "Profile.complete.message".localized()
}

class ProfileViewController: UIViewController, BindableType {

    @IBOutlet weak private var avatarImageView: UIImageView!
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var okButton: UIButton!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var addressTextField: HoshiTextField!
    @IBOutlet weak private var phoneTextField: HoshiTextField!
    @IBOutlet weak private var ageTextField: HoshiTextField!
    @IBOutlet weak private var nameTextField: HoshiTextField!
    
    var viewModel: ProfileViewModel!
    var avatarImage = PublishSubject<UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        setupAvatarImageView()
    }
    
    func setupAvatarImageView() {
        avatarImageView.cornerRadius(corner: avatarImageView.frame.height/2)
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        titleLabel.text = Constants.titleLabel
    }

    func bindViewModel() {
        let input = ProfileViewModel.Input(fullName: nameTextField.rx.text.orEmpty.asDriver(),
                                           address: addressTextField.rx.text.orEmpty.asDriver(),
                                           age: ageTextField.rx.text.orEmpty.asDriver(),
                                           avatar: avatarImage.asDriverOnErrorJustComplete(),
                                           backTrigger: backButton.rx.tap.asDriver(),
                                           oktrigger: okButton.rx.tap.asDriver(),
                                           imageViewTrigger: avatarImageView.rx.tapGesture().when(.recognized)
                                            .asDriverOnErrorJustComplete())
        let output = viewModel.transform(input)
        output.backTrigger
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.okTrigger
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.imageViewTrigger
            .drive(pickerViewBinder)
            .disposed(by: rx.disposeBag)
    }
    
    private var pickerViewBinder: Binder<Void> {
        return Binder(self, binding: { vc, _  in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            vc.present(picker, animated: true, completion: {
             //   MBProgressHUD.hide(for: vc.view, animated: true)
            })
        })
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        guard let editImage = info["UIImagePickerControllerEditedImage"] else {
            if let originalImage = info["UIImagePickerControllerOriginalImage"] {
                selectedImage = originalImage as? UIImage ?? UIImage()
                avatarImageView.image = selectedImage
                avatarImage.onNext(originalImage as? UIImage ?? UIImage())
            }
            return
        }
        selectedImage = editImage as? UIImage ?? UIImage()
        avatarImageView.image = selectedImage
        avatarImage.onNext(editImage as? UIImage ?? UIImage())
        dismiss(animated: true, completion: nil)
    }
}
