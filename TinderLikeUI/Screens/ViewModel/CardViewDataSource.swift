//
//  CardViewDataSource.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
protocol CardViewDataSourceProtocol {
    func numberOfPersons() -> Int?
    func personView(at index: Int) -> PersonInfo?
    func backgroundView(at index: Int) -> UIView?
}
class CardViewDataSource {
    
    var listofPerons = [PersonInfo]()
    
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
                    print(results)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension CardViewDataSource: CardViewDataSourceProtocol {
    
    func numberOfPersons() -> Int? {
        listofPerons.count
    }
    
    func personView(at index: Int) -> PersonInfo? {
        if index >= 0 && index < listofPerons.count {
         return listofPerons[index]

        } else {
         return  nil
        }
    }
    
    func backgroundView(at index: Int) -> UIView? {
        nil
    }
    
}
