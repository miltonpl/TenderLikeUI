//
//  LockView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/27/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class UnlockView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.tableFooterView = UIView()
            self.tableView.estimatedRowHeight = 100
//            self.tableView.rowHeight = 60
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UnlockTableViewCell.nib(), forCellReuseIdentifier: UnlockTableViewCell.identifier)
            
        }
    }

    @IBOutlet weak var unlockBenefits: UIButton!
    var benefits = [UserInfo]()
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
        benefits.append(UserInfo(image: UIImage(named: "synchronize"), title: "Rewind you last swipe", subtitle: "Go back and swipe again"))
        benefits.append(UserInfo(image: UIImage(named: "change_location"), title: "Change you location", subtitle: "Swipe and match with people anywhere in the world"))
        benefits.append(UserInfo(image: UIImage(named: "heart_lock"), title: "Unlimited likes", subtitle: "Have fun swiping"))
        benefits.append(UserInfo(image: UIImage(named: "noAdds"), title: "Turn off Adds", subtitle: "Uninterrupted play"))
        tableView.reloadData()
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
// MARK: - UITableViewDataSource and UITableViewDelegate

extension UnlockView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.benefits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnlockTableViewCell", for: indexPath) as? UnlockTableViewCell else {
            fatalError("Unable to dequeue FavoriteTableViewCell")
        }
        let item = benefits[indexPath.row]
        cell.configure(title: item.title, subtitle: item.subtitle)
        return cell
    }
}
