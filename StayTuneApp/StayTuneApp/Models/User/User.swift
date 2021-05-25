//
//  User.swift
//  StayTuneApp
//
//  Created by Rishat on 06.04.2021.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let username: String
    let password: String
    let city: String?
    let image: String?
    let telegram: String?
    var isFriend: Bool?
}
