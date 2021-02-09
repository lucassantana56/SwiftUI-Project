//
//  MyWord.swift
//  mywords
//
//  Created by Lucas Santana on 23/01/2021.
//

import Foundation

struct MyWord: Codable {
    let message: String
    let data: [Word]
}

struct Word: Codable, Equatable, Identifiable {
    let createdAt, id, name: String
    let size: Int
    let key: String
    let url: String
    let photoWords, userID: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case createdAt
        case id = "_id"
        case name, size, key, url, photoWords
        case userID = "userId"
        case v = "__v"
    }
}
