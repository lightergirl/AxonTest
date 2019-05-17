//
//  User.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/15/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import Foundation

struct User {
    var fullName: String
    var smallImageUrl: String
    var imageUrl: String
    var gender: String
    var age: Int
    var dob: String
    var phone: String
    var cell: String
    var email: String
    
    init(with result: Result) {
        self.fullName = "\(result.name.first) \(result.name.last)".capitalized(with: .current)
        self.smallImageUrl = result.picture.thumbnail
        self.imageUrl = result.picture.large
        self.gender = result.gender.rawValue
        self.age = result.dob.age
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        let fixedDate = dateFormatter.string(from: result.dob.date)
        self.dob = fixedDate
        let phoneNumber = result.phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.phone = phoneNumber
        let cellNumber = result.cell.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.cell = cellNumber
        self.email = result.email
    }
}
