//
//  ShadowView.swift
//  Knot
//
//  Created by Tuan Truong on 1/22/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

protocol HasShadow {
    var shadowOffsetWidth: Double { get set }
    var shadowOffsetHeight: Double { get set }
    var shadowRadius: CGFloat { get set }
    var shadowColor: UIColor? { get set }
    var shadowOpacity: Float { get set }
}

extension HasShadow where Self: UIView {
    func configRadiusAndShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}

final class ShadowView: UIView, HasShadow {
    var shadowOffsetWidth: Double = 0
    var shadowOffsetHeight: Double = 1
    var shadowRadius: CGFloat = 1
    var shadowColor: UIColor? = UIColor.black
    var shadowOpacity: Float = 0.1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configRadiusAndShadow()
    }
}

final class ShadowButton: UIButton, HasShadow {
    var shadowOffsetWidth: Double = 0
    var shadowOffsetHeight: Double = 1
    var shadowRadius: CGFloat = 1
    var shadowColor: UIColor? = UIColor.black
    var shadowOpacity: Float = 0.1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configRadiusAndShadow()
    }
}
