//
//  UIImageView+Ext.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadImage(_ url: URL?) {
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority) { image, error, _, _ in
            if error != nil {
                self.image = image
            } else {
//                print(error ?? "It cannot print error")
            }
        }
    }
}
