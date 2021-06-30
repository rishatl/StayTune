//
//  ConcertDetails.swift
//  StayTuneApp
//
//  Created by Rishat on 02.05.2021.
//

import Foundation

struct ConcertDetails {
    let id: Int
    let name: String
    let location: String
    let latitude: Double
    let longitude: Double
    let date: Date
    let about: String
    let singer: String
    let singerUrl: URL?
    let price: Int
    let imageUrl: URL?
    var subscribers: [User]
    var userLiked: [User]
}

extension ConcertDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case latitude
        case longitude
        case date
        case about
        case singer
        case singerUrl
        case price
        case imageUrl
        case subscribers
        case userLiked
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let dateString = try container.decode(String.self, forKey: .date)
        date = DateFormatter.getDateFromString(dateString)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(String.self, forKey: .location)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        about = try container.decode(String.self, forKey: .about)
        singer = try container.decode(String.self, forKey: .singer)
        singerUrl = try container.decode(URL.self, forKey: .singerUrl)
        price = try container.decode(Int.self, forKey: .price)
        imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        subscribers = try container.decode(Array<User>.self, forKey: .subscribers)
        userLiked = try container.decode(Array<User>.self, forKey: .userLiked)
    }
}
