//
//  UserProfileView.swift
//  KnotBuilder
//
//  Created by Tuan Truong on 3/13/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class UserProfileView: UICollectionReusableView, NibReusable {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.do {
            $0.clipsToBounds = true
        }
        
        nameLabel.do {
            $0.text = "Long"
        }
    }
    
    func configView(with user: User?) {
        coverImageView.image = #imageLiteral(resourceName: "cover")
        avatarImageView.image = #imageLiteral(resourceName: "group1")
        nameLabel.text = "Long"
    }
}
