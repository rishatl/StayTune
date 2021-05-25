//
//  MockCouncilService.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation

class MockConcertService: ConcertService {

    private lazy var mockConcert = Concert(
        id: 0,
        name: "Anyone",
        location: "Anywere",
        imageUrl: nil
    )

    private lazy var mockConcertDetails = ConcertDetails(
        id: 0,
        name: "Anyone",
        location: "Anywere",
        latitude: 0.0,
        longitude: 0.0,
        date: DateFormatter.getDateFromString("0000-00-00"),
        about: "Anything",
        singer: "Anyone",
        singerUrl: nil,
        price: 0,
        imageUrl: nil,
        subscribers: [],
        userLiked: []
    )

    func loadConcerts(completion: @escaping (Result<[Concert], ConcertErrors>) -> Void) {
        completion(.success(Array(repeating: mockConcert, count: 10)))
    }

    func loadConcertDetails(id: Int, completion: @escaping (Result<ConcertDetails, ConcertErrors>) -> Void) {
        completion(.success(mockConcertDetails))
    }

    func addFavorite(id: Int, completion: @escaping (Result<Void, ConcertErrors>) -> Void) {
        completion(.success(()))
    }
}
