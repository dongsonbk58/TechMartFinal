//
//  CategoryCollectionViewCell.swift
//  TechMartFinal
//
//  Created by ThanhLong on 9/6/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var titleCategoryLabel: UILabel!
    @IBOutlet private weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configView() {
        
    }
}

