//
//  UIView+.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}

extension UIView {
    // swiftlint:disable force_cast
    class func loadFromNib<T: UIView>(_ type: T.Type, bundle: Bundle = Bundle.main) -> T {
        return bundle.loadNibNamed(type.className, owner: self, options: nil)?.first as! T
    }
    
    /// Make view round
    func roundView() {
        let minSize = min(bounds.width, bounds.height)
        layer.cornerRadius = minSize / 2
        layer.masksToBounds = true
    }
    
    func border(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func cornerRadius(corner: CGFloat) {
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }
    
    func roundLeft() {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: bounds.height / 2, height: bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }
    
    func roundTop(corner: CGFloat = 0.0) {
        let rightCornet = corner != 0.0 ? corner : bounds.height / 2
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: rightCornet, height: rightCornet))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }
    
    func roundRight() {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: bounds.height / 2, height: bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }
    
    func removeRound() {
        layer.mask = nil
        layer.cornerRadius = 0.0
    }
    
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
    
    func shadow(offset: CGSize = .zero, radius: CGFloat = 5.0, opacity: Float = 0.3) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func setGradientForView() {
        let greenCenter = UIColor.colorWithHexaCode(ColorConstants.centerGreen)
        let greenLight = UIColor.colorWithHexaCode(ColorConstants.lightGreen)
        let greenDark = UIColor.colorWithHexaCode(ColorConstants.darkGreen)
        
        let gradient = CAGradientLayer()
        gradient.colors = [greenDark.cgColor, greenCenter.cgColor, greenLight.cgColor]
        gradient.frame = self.frame
        gradient.startPoint = CGPoint(x: 1, y: 0)
        layer.sublayers = nil
        layer.addSublayer(gradient)
    }
    
    func pushTransition(_ duration: CFTimeInterval, isTransitionLeft: Bool) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = isTransitionLeft ? kCATransitionFromLeft: kCATransitionFromRight
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
    
    func setGradientForUIView(_ colors: UIColor..., isCorner: Bool) {
        let gradient = CAGradientLayer()
        var gradientColors: [CGColor] = []
        for color in colors {
            gradientColors.append(color.cgColor)
        }
        gradient.colors = gradientColors
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        if isCorner {
            gradient.cornerRadius = 10
        }
        layer.insertSublayer(gradient, at: 0)
    }
}
