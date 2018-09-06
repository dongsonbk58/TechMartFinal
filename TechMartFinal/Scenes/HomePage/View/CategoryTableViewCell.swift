//
//  CategoryTableViewCell.swift
//  TechMartFinal
//
//  Created by ThanhLong on 9/6/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, NibReusable  {

    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    
    var selectedCell: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.register(cellType: CategoryCollectionViewCell.self)
        categoryCollectionView.delegate = self
    }
    
    func configView(data: BehaviorRelay<[Category]>) {
        _ = data.asObservable().bind(to: categoryCollectionView.rx.items) { collectionView, index, collection in
            return collectionView.dequeueReusableCell(for: IndexPath(row: index, section: 0),
                                                      cellType: CategoryCollectionViewCell.self)
                .then {
                     $0.configView()
                }
        }
    }
}
extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell?()
    }
}
