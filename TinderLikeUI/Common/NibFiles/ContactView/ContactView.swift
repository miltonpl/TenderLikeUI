//
//  ContactView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/28/20.
//  Copyright © 2020 Milton. All rights reserved.
//
import UIKit
class ContactView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var cellPhoneLabel: UILabel!
    @IBOutlet weak var homePhoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

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
    
    func configure(cellPhone: String, homePhone: String, strUrl: String?, email: String) {
        self.cellPhoneLabel.text = cellPhone
        self.homePhoneLabel.text = homePhone
        self.emailLabel.text = email
        self.imageView.layer.cornerRadius = self.imageView.frame.width/2
        if let strUrl = strUrl, let url = URL(string: strUrl) {
            self.imageView.downloadImage(url)
        }
    }
    
    @IBAction func homePhoneAction(_ sender: UIButton) {
        
    }
    
    @IBAction func cellPhoneAction(_ sender: UIButton) {
    }
    
    @IBAction func emailAction(_ sender: UIButton) {
        
    }
    
    @IBAction func messageAction(_ sender: UIButton) {
        
    }
    
}
