//
//  CardView.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
struct Tinder: Decodable {
    var results: [Person]?
}

struct Person: Decodable {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob: DOB?
    var registered: DOB?
    var phone: String?
    var cell: String?
    var personId: PersonId?
    var picture: Picture?
    var natinality: String?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case email
        case login
        case dob
        case registered
        case phone
        case cell
        case personId = "id"
        case picture
        case natinality = "nat"
    }
}

struct PersonId: Decodable {
    var name: String?
    var value: String?
}

struct Picture: Decodable {
    var largeUrl: String?
    var mediumUrl: String?
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case largeUrl = "large"
        case mediumUrl = "medium"
        case thumbnailUrl = "thumnail"
    }
}

struct DOB: Decodable {
    var date: String?
    var age: Int?
}

struct Login: Decodable {
    var uuid: String?
    var username: String?
    var password: String?
    var salt: String?
    var md5: String?
    var sha1: String?
    var sha256: String?
}

struct Name: Decodable {
    var title: String?
    var first: String?
    var last: String?
}
struct Location: Decodable {
    var street: Street?
}

struct Street: Decodable {
    var number: Int?
    var name: String?
}

struct PersonInfo {
    var profile: UIView
}
struct PersonBasicInfo {
    var image: UIImage?
    var firstName: String
    var lastName: String
}
