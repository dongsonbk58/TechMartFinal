//
//  UITableView.swift
//
//  Created by Shohei Ohno on 2017/07/17.
//  Copyright © 2017年 s0hno. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerHeadFooterClass<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName
        
        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName

        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T where T: ReusableView {
        guard let cell =  self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell =  self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T where T: ReusableView {
        guard let cell =  self.dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue hear footer with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    func cellAtIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T? {
        return cellForRow(at: IndexPath(row: row, section: section)) as? T
    }
    
    func reloadDataAfter(_ completion: (() -> Void)? = nil) {
        reloadData()
        guard let comp = completion else { return }
        DispatchQueue.main.async(execute: { comp() })
    }
    
    func isLastCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row == (numberOfRows(inSection: indexPath.section) - 1)
    }
    
    func isLastSectionAndLastRow(at indexPath: IndexPath) -> Bool {
        return indexPath.section == (numberOfSections - 1) && isLastCell(at: indexPath)
    }
    
    func lastIndexPath() -> IndexPath? {
        for index in (0 ..< numberOfSections).reversed() {
            if numberOfRows(inSection: index) > 0 {
                return IndexPath(row: numberOfRows(inSection: index) - 1, section: index)
            }
        }
        return nil
    }
    
    func scrollToBottom(animated: Bool) {
        guard let indexPath = lastIndexPath() else {
            return
        }
        scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
}

extension UITableViewCell {
    var superTableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}
