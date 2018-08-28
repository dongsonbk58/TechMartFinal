//
//  MenuCell.swift
//  KnotBuilder
//
//  Created by Tuan Truong on 3/12/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var containerView: ShadowView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.do {
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor(white: 205).cgColor
            $0.shadowRadius = 3
            $0.shadowOffsetWidth = 2
            $0.shadowOffsetHeight = 2
        }
        
        menuLabel.do {
            $0.font = UIFont.hiraginoSans(style: .w3, size: 12)
        }
    }

}
