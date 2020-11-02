//
//  ProfileView.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
class ProfileView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(self.contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(fullname: String, strUrl: String?) {
        self.titleLabel.text = "My name is"
        self.fullnameLabel.text = fullname
        self.imageView.layer.cornerRadius = self.imageView.frame.width/2
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = CustomCGColor.grey
        if let strUrl = strUrl, let url = URL(string: strUrl) {
            self.imageView.downloadImage(url)
        }
    }
}
