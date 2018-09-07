//
//  CategoryDetailTableViewCell.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 9/7/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private  weak var categoryDetailCollectionView: UICollectionView!
    @IBOutlet private weak var titleCategoryLabel: UILabel!
    @IBOutlet private weak var categoryBannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView() {
        
    }
}
