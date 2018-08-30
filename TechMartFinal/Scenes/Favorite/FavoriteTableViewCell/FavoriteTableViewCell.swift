//
//  FavoriteTableViewCell.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configUI(product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "\(product.price)"
    }
}
