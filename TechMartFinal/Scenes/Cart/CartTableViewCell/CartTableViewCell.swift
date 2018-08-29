//
//  CartTableViewCell.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var imageProductImageView: UIImageView!
    @IBOutlet private weak var countProductLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    @IBOutlet private weak var incCountButton: UIButton!
    @IBOutlet private weak var decCountButton: UIButton!
    @IBOutlet private weak var priceProductLabel: UILabel!
    @IBOutlet private weak var titleProductLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView(with product: Product) {
        titleProductLabel.text = product.title
        priceProductLabel.text =  "\(product.price)"
        
    }
    
}
