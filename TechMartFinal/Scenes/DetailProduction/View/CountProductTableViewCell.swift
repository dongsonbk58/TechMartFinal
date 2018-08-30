//
//  CountProductTableViewCell.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CountProductTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var countTitleLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var countProductLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        countProductLabel.do {
            $0.font = UIFont.hiraginoSans(size: 15)
        }

    }
    
    func configData() {
        print("dau xanh")
    }
}
