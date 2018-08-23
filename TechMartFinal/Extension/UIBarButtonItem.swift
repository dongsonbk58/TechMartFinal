//
//  UIBarButtonItem.swift
//  FAC_IOS
//
//  Created by nguyen.dong.son on 6/28/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import UIKit

private var handle: UInt8 = 0
private struct Constants {
    static let key = "view"
}

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        get {
            return objc_getAssociatedObject(self, &handle) as? CAShapeLayer
        }
        set(badge) {
            objc_setAssociatedObject(self, &handle, badge, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addBadge(stringNumber: String, radius: CGFloat, fontSize: CGFloat, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: Constants.key) as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()

        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = radius
        let location = CGPoint(x: view.frame.width - (radius / 2), y: (radius / 2))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = stringNumber
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = fontSize
        label.frame = CGRect(origin: CGPoint(x: location.x - radius / 2, y: location.y - radius / 2), size: CGSize(width: radius, height: radius))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        self.badgeLayer = badge
    }
    
    func updateBadge(stringNumber: String) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = stringNumber
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}
