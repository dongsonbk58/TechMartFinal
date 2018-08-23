//
//  Array.swift
//
//  Created by Dang Nguyen Vu on 12/17/17.
//  Copyright © 2017 XProduction. All rights reserved.
//

import Foundation

extension Array {
    var second: Element? {
        return get(1)
    }

    var third: Element? {
        return get(2)
    }

    func get(_ index: Int) -> Element? {
        guard index < count else {
            return nil
        }
        return self[index]
    }
}

extension Array where Element: Equatable {
    mutating func merge(with newElements: [Element]?) {
        guard let newElements = newElements else {
            return
        }
        let filterArray = newElements.filter { (element) -> Bool in
            return !self.contains(element)
        }
        self.append(contentsOf: filterArray)
    }
}
