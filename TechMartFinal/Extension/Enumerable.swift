//
//  Enumerable.swift
//
//  Created by Dang Nguyen Vu on 7/27/17.
//  Copyright © 2017 s0hno. All rights reserved.
//

import Foundation

protocol Enumerable {
    associatedtype Case = Self
}

extension Enumerable where Case: Hashable {
    private static var iterator: AnyIterator<Case> {
        var n = 0
        return AnyIterator {
            defer { n += 1 }
            let next = withUnsafePointer(to: &n) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Case.self).pointee
            }
            return next.hashValue == n ? next : nil
        }
    }

    static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(self.iterator).enumerated()
    }

    static var elements: [Case] {
        return Array(self.iterator)
    }

    static var count: Int {
        return self.elements.count
    }
}
