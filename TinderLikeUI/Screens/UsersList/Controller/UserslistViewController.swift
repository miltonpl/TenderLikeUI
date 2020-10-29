//
//  UserslistViewController.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class UserslistViewController: UIViewController {
    @IBOutlet private weak var viewContainer: ViewContainer!
    private var viewModel = UserViewDataSource()
    private var users = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.dataSourceProtocol = self
        viewModel.delegate = self
        viewModel.fetchData("3")
    }
}

extension UserslistViewController: UserViewDataSourceProtocol {
    
    func numberOfUsers() -> Int {
        users.count
    }
    
    func getUserView(at index: Int) -> SwipeableUserViewCard {
        print("get User View: index:", index)
        let customView = SwipeableCustomView()
        customView.person =  users[index]
        print(users[index].cell ?? "No cell")
        return customView
    }
    
    func viewForNoUser() -> UIView? {
        return nil
    }
}
extension UserslistViewController: UserViewDataSourceDelegate {
    
    func usersData(users: [Person]) {
        self.users = users
        print("users count: ", users.count)
        viewContainer.dataSourceProtocol = self
    }
}
