//
//  InformationTableViewCell.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/31/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    static let identifier = "InformationTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "InformationTableViewCell", bundle: nil)
    }
}
