//
//  Helper.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/27/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import Foundation

struct Helper {
    //    let input = "1992-06-21T19:47:19.911Z"
    func convertDateFormatter(date: String) -> String {
        //this your string date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: date)
        //this is what you want to convert format
        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    //    print(convertDateFormatter(date: input))
//    print:1992 Jun Sunday 19:47
}
