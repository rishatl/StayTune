//
//  Subscriber.swift
//  StayTuneApp
//
//  Created by Rishat on 14.05.2021.
//

import UIKit

struct Subscriber: Codable, Equatable {
    let id: Int
    let email: String
    let username: String
    var isFriend: Bool
    let image: String?
}
