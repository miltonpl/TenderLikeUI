//
//  ProfileView.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
class ProfileView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    func configure(fullname: String, image: UIImage?) {
        self.imageView.image = image
        self.titleLabel.text = "My name is"
        self.fullnameLabel.text = fullname
    }
}
