//
//  RandomUserResponse.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/15/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [Result]
    let info: Info
}

struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

struct Result: Codable {
    let gender: Gender
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Dob
    let phone: String
    let cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

struct Dob: Codable {
    let date: Date
    let age: Int
}

struct ID: Codable {
    let name: String
    let value: String?
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable {
    let offset: String
    let description: String
}

struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

enum ResponseEnum: Codable {
    case error(String)
    case data(RandomUserResponse)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .error(x)
            return
        }
        if let x = try? container.decode(RandomUserResponse.self) {
            self = .data(x)
            return
        }
        throw DecodingError.typeMismatch(ResponseEnum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Response"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .error(let x):
            try container.encode(x)
        case .data(let x):
            try container.encode(x)
        }
    }
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
