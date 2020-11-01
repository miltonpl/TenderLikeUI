//
//  CalendarView.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
enum InformationType: String {
    case birthday = "My birthday"
    case gender = "My gender"
    case interested = "I am interested in"
    case age = "age"
}
class InformationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.rowHeight = 50
            self.tableView.isScrollEnabled = false
            self.tableView.allowsSelection = false
            self.tableView.register(InformationTableViewCell.nib(), forCellReuseIdentifier: InformationTableViewCell.identifier)
        }
    }
    var infoDetails = [(type: InformationType, content: String)]()
    
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
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure (strUrl: String, birthday: String, age: String, gender: String, interesteddIn: String) {
        self.infoDetails.append((.birthday, birthday))
        self.infoDetails.append((.gender, gender))
        self.infoDetails.append((.interested, interesteddIn))
        self.infoDetails.append((.age, age))
        self.imageView.downloadImage(URL(string: strUrl))
        self.tableView.reloadData()
        self.imageView.layer.cornerRadius = self.imageView.frame.width/2
    }
}
extension InformationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.infoDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as? InformationTableViewCell else {
            fatalError("Unable to dequeueResuableCell with Identifier InformationTableViewCell")
        }
        let item = self.infoDetails[indexPath.row]
        cell.configure(title: item.type.rawValue, subtitle: item.content)
        return cell
    }
}
