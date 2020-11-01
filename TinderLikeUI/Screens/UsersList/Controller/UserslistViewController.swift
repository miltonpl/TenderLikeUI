//
//  UserslistViewController.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import MapKit
import UIKit

class UserslistViewController: UIViewController {
    
    @IBOutlet private weak var customViewHandler: CustomViewHandler!
    
    private var viewModel = UsersDataSource()
    private lazy var locationHandler = LocationHandler(delegate: self)
    private var users = [Person]()
    private var location: CLLocation?
    private var currentUser: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationHandler.getUserLocation()
        customViewHandler.delegate = self
        viewModel.delegate = self
        viewModel.fetchData("6")
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if let currentUser = self.currentUser {
            do {
                try DBManager.shared.insert(user: currentUser)
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func dislikeAction(_ sender: UIBarButtonItem) {
        customViewHandler.userToDequeue()
    }
}

extension UserslistViewController: UsersDataSourceDelegate {
    
    func usersData(users: [Person]) {
        self.users = users
        customViewHandler.dataSourceProtocol = self
    }
}
extension UserslistViewController: DataSouceProtocol {
    func numberOfUsers() -> Int {
        users.count
    }
    
    func getUserView(at index: Int) -> CustomView {
        let customView = CustomView()
        customView.locationDelegate = self
        customView.person = users[index]
        return customView
    }
    
    func viewForNoUser() -> UIView? {
        nil
    }
}

extension UserslistViewController: MKMapViewDelegate, LocationHandlerProtocol {
    func received(location: CLLocation) {
        self.location = location
    }
    
    func locationDidFail(withError error: Error) {
        print(error)
    }
}

extension UserslistViewController: MapViewDelegate {
    func getUserLocation() -> CLLocation? {
        return location
    }
}

extension UserslistViewController: CustomViewHandlerDelegate {
    func userInQueue(frontUser: UserInfo) {
        self.currentUser = frontUser
    }
}
