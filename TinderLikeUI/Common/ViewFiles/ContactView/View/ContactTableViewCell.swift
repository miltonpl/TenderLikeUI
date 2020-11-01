//
//  ContactTableViewCell.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/30/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let identifier = "ContactTableViewCell"
    
    @IBOutlet weak  var itemImageView: UIImageView!
    @IBOutlet weak  var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "ContactTableViewCell", bundle: nil)
    }
    
    func configure(image: UIImage?, name: String) {
            self.itemImageView.image = image
        self.nameLabel.text = name
    }
}
