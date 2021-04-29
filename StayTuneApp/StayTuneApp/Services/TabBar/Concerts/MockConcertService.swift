//
//  MockCouncilService.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation

class MockConcertService: ConcertService {
    private lazy var mockMember: ConcertMember = ConcertMember(
        id: "holy-wan",
        name: "Obi-Wan Kenobi",
        location: "Anywere"
//        rank: .master,
//        imageUrl: nil
    )
    private lazy var mockMemberDetails: ConcertMemberDetails = ConcertMemberDetails(
        councilMember: mockMember,
        bio: "The perfect one."
    )

    func loadMembers(completion: @escaping (Result<[ConcertMember], ConcertErrors>) -> Void) {
        completion(.success(Array(repeating: mockMember, count: 10)))
    }

    func loadMemberDetails(id: String, completion: @escaping (Result<ConcertMemberDetails, Error>) -> Void) {
        completion(.success(mockMemberDetails))
    }
}
