//
//  FavoriteTableViewCell.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/29/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let identifier = "FavoriteTableViewCell"
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(user: UserInfo) {
        self.itemImageView.layer.cornerRadius = self.itemImageView.frame.width/2
        if let image = user.image {
            self.itemImageView.image = image
            self.itemImageView.removeFromSuperview()
        } else {
            self.itemImageView.downloadImage(URL(string: user.imageUrl ?? ""))
        }
        self.titleLabel.text = user.title
        self.subtitleLabel.text = user.subtitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteTableViewCell", bundle: nil)
    }
    
}
