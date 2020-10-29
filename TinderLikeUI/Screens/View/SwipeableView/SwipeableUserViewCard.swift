//
//  SwipeablePersonViewCard.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class SwipeableUserViewCard: SwipeableView, NibView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
}
