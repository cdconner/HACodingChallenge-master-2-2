//
//  DateFormatter.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/9/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import Foundation


let string = "2017-01-27T18:36:36Z"

let dateFormatter = DateFormatter()
let tempLocale = dateFormatter.locale // save locale temporarily
dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let date = dateFormatter.date(from: string)!
dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
dateFormatter.locale = tempLocale // reset the locale
let dateString = dateFormatter.string(from: date)
print("EXACT_DATE : \(dateString)")
