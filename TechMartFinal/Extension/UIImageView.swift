//
//  UIImageView.swift
//  FAC_IOS
//
//  Created by khuc.d.m.nguyen on 5/14/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import UIKit
extension UIImageView {
    func loadImageFrom(urlString: String, placeHolderImgName: String) {
        DispatchQueue(label: "newThread").async {
            guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: placeHolderImgName)
                }
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
