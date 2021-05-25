//
//  Concert.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation

struct Concert: Codable {
    let id: Int
    let name: String
    let location: String
    let imageUrl: URL?
}
