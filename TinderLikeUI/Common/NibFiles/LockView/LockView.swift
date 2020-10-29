//
//  LockView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/27/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class LockView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var rewindView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var blockView: UIView!
    
    @IBOutlet weak var unlockBenefits: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    func configure() {
        self.unlockBenefits.layer.cornerRadius = 15
        
        self.rewindView.layer.cornerRadius = rewindView.bounds.width/2
        self.locationView.layer.cornerRadius = rewindView.bounds.width/2
        self.blockView.layer.cornerRadius = rewindView.bounds.width/2
        self.heartView.layer.cornerRadius = rewindView.bounds.width/2
    }
    
    @IBAction func unlockAction(_ sender: UIButton) {
        print("unblock Benefits")
        
    }
    
    func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
