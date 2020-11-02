//
//  FavoritesViewController.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/29/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
            self.tableView.tableFooterView = UIView()
            self.tableView.rowHeight = 120
        }
    }
    
    var users = [UserInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUser()
    }
    
    func setUser() {
        do {
            self.users = try DBManager.shared.read()
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    func setupTabBarItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove All", style: .plain, target: self, action: #selector(removeAllUser(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = CustomColor.grey
    }
    
    @objc func removeAllUser(_ sender: UIBarButtonItem) {
        self.alertCreation()
    }
    
    func alertCreation() {
        let alert = UIAlertController(title: "Delete All Users", message: "You have selected to delete All Users", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete All Users", style: .destructive, handler: { _ in
            self.users = []
            self.tableView.reloadData()
            do {
                try DBManager.shared.deleteAll()
            } catch {
                print(error)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else {
            fatalError("Unable to dequeue FavoriteTableViewCell")
        }
        cell.configure(user: users[indexPath.row])
        return cell
    }
}
