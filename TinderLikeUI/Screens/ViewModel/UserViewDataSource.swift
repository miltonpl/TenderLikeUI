//
//  CardViewDataSource.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

protocol UserViewDataSourceProtocol {
    func numberOfUsers() -> Int
    func getUserView(at index: Int) -> SwipeableUserViewCard
    func viewForNoUser() -> UIView?
}

protocol UserViewDataSourceDelegate: AnyObject {
    func usersData(users: [Person])
}

class UserViewDataSource {
    weak var delegate: UserViewDataSourceDelegate?
    
    func fetchData(_ nUsers: String) {
        
        guard var urlComponents = URLComponents(string: RandomUser.BASEURL) else { return }
        var parameter = RandomUser.parameter
        parameter["results"] = nUsers
        var elements: [URLQueryItem] = []
        for (key, value) in parameter {
            elements.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = elements
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        ServiceManager.manager.request(Tinder.self, withRequest: request) { result in
            switch result {
            case .success(let place):
                if let results = place.results {
//                    print(results)
                    self.delegate?.usersData(users: results)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
