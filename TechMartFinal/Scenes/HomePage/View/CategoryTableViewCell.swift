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
    fileprivate var screenSize = UIScreen.main.bounds.size

    var selectedCell: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.register(cellType: CategoryCollectionViewCell.self)
        categoryCollectionView.delegate = self
    }
    
    func configView(data: BehaviorRelay<[Category]>) {
        categoryCollectionView.dataSource = nil
        _ = data.asObservable().bind(to: categoryCollectionView.rx.items) { collectionView, index, collection in
            return collectionView.dequeueReusableCell(for: IndexPath(row: index, section: 0),
                                                      cellType: CategoryCollectionViewCell.self)
                .then {
                     $0.configView()
                }
        }
    }
}
extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenSize.width - 5) / 4, height: (collectionView.bounds.size.height - 4) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1,1,1,1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell?()
    }
}
