//
//  AnlockTableViewCell.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 11/1/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class UnlockTableViewCell: UITableViewCell {
    static let identifier = "UnlockTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(title: String, subtitle: String) {
         self.titleLabel.text = title
         self.subtitleLabel.text = subtitle
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
     }
     
     static func nib() -> UINib {
         return UINib(nibName: "UnlockTableViewCell", bundle: nil)
     }
}
