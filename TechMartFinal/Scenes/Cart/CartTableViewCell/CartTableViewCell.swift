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
    
    var decProductAction: (() -> Void)?
    var incProductAction: (() -> Void)?
    var removeProductAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func removeProductAction(_ sender: UIButton) {
        removeProductAction?()
    }
    
    @IBAction func incProductAction(_ sender: UIButton) {
        incProductAction?()
    }
    
    @IBAction func decProductAction(_ sender: UIButton) {
        decProductAction?()
    }
    
    func configView(with cart: Cart) {
        titleProductLabel.text = cart.product?.title ?? ""
        priceProductLabel.text =  "\(cart.product?.price ?? 0)"
        countProductLabel.text = "\(cart.count)"
    }
    
}
