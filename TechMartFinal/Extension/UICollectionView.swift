//
//  UICollectionView.swift
//
//  Created by Dang Nguyen Vu on 7/20/17.
//  Copyright © 2017 s0hno. All rights reserved.
//

import UIKit

private struct Constant {
    static let defaultMiniumSpace: CGFloat = 3.0
    static let defaultNumberItemInRow: CGFloat = 3
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    // swiftlint:disable force_cast
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }

    // swiftlint:disable force_cast
    func cellAtIndex<T: UICollectionViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T {
        return cellForItem(at: IndexPath(row: row, section: section)) as! T
    }

    func reloadDataAfter(_ completion: (() -> Void)? = nil) {
        reloadData()
        guard let comp = completion else { return }
        DispatchQueue.main.async(execute: { comp() })
    }
}
