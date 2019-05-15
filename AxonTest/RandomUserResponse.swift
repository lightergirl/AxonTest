//
//  RandomUserResponse.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/15/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [Result]?
    let info: Info?
}

struct Info: Codable {
    let seed: String?
    let results: Int?
    let page: Int?
    let version: String?
}

struct Result: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
}

struct Dob: Codable {
    let date: Date?
    let age: Int?
}

struct ID: Codable {
    let name: String?
    let value: String?
}

struct Location: Codable {
    let street, city, state: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
}

struct Coordinates: Codable {
    let latitude, longitude: String?
}

struct Timezone: Codable {
    let offset, description: String?
}

struct Login: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

struct Name: Codable {
    let title, first, last: String?
}

struct Picture: Codable {
    let large, medium, thumbnail: String?
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
