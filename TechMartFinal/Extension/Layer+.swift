//
//  Layer+.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

extension CALayer {
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
            gradient.cornerRadius = 5
        }
        self.insertSublayer(gradient, at: 0)
    }
}
