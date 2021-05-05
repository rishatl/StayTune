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
}

extension ConcertDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case patientFirstName = "patient_first_name"
        case patientLastName = "patient_last_name"
        case patientPatronymic = "patient_patronymic"
        case preliminaryDiagnosis = "preliminary_diagnosis"
        case status
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let createdAtString = try container.decode(String?.self, forKey: .createdAt)
        createdAt = Date.from(isoString: createdAtString!)!
        patientFirstName = try container.decode(String.self, forKey: .patientFirstName)
        patientLastName = try container.decode(String.self, forKey: .patientLastName)
        patientPatronymic = try container.decode(String.self, forKey: .patientPatronymic)
        preliminaryDiagnosis = try container.decode(String.self, forKey: .preliminaryDiagnosis)
        status = try container.decode(Status.self, forKey: .status)

