//
//  ContactView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/28/20.
//  Copyright © 2020 Milton. All rights reserved.
//
import UIKit
enum ContactType {
    case phone
    case cell
    case email
    case message
}

class ContactView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.estimatedRowHeight = 100
            self.tableView.tableFooterView = UIView()
            self.tableView.isScrollEnabled = false
            self.tableView.allowsSelection = false
            self.tableView.register(ContactTableViewCell.nib(), forCellReuseIdentifier: ContactTableViewCell.identifier)
        }
    }
    
    var contactDetails = [(type: ContactType, content: String)]()

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
    
    func configure(contact: Contact) {
       
        if let phone = contact.homePhone {
            self.contactDetails.append((.phone, phone))
        }
        
        if let email = contact.email {
            self.contactDetails.append((.email, email))
        }
        
        if let cell = contact.cellPhone {
            self.contactDetails.append((.cell, cell))
            self.contactDetails.append((.message, cell))
        }
        
        self.tableView.reloadData()
        
        if let strUrl = contact.url, let url = URL(string: strUrl) {
            self.imageView.downloadImage(url)
            self.imageView.layer.cornerRadius = imageView.frame.width/2
            self.imageView.layer.borderWidth = 1
            self.imageView.layer.borderColor = CustomCGColor.grey
            self.myImageView.layer.cornerRadius = myImageView.frame.width/2
            self.myImageView.layer.borderColor = CustomCGColor.grey
            self.myImageView.layer.borderWidth = 1
            
        }
    }
    
    func makeACall() {
        
        let strPhone = "holelelle"
        let number = strPhone.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        print(number)
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Did Not work")
        }
    }
}
extension ContactView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell else {
            fatalError("Unable to dequeueResuableCell with Identifier CantactTableViewCell")
        }
        let item = contactDetails[indexPath.row]
        print(item)
        switch item.type {
        case .phone:
            cell.configure(image: UIImage(named: "phone"), name: item.content)
        case .cell:
            cell.configure(image: UIImage(named: "cell"), name: item.content)
        case .email:
            cell.configure(image: UIImage(named: "email"), name: item.content)
        case .message:
            cell.configure(image: UIImage(named: "messages"), name: item.content)

        }
        return cell
    }
}
