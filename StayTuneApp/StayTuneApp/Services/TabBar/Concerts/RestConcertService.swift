//
//  RestCouncilService.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation
import Alamofire
import UIKit
import KeychainAccess

protocol ConcertService {
    func loadMembers(completion: @escaping (Result<[ConcertMember], ConcertErrors>) -> Void)
    func loadMemberDetails(id: String, completion: @escaping (Result<ConcertMemberDetails, Error>) -> Void)
}

class RestConcertService: ConcertService {
    let baseUrl: URL = {
        guard let url = URL(string: "https://raw.githubusercontent.com/AZigangaraev/ITIS_2020_2_CW_1/main") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let listConcertsUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/concerts") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    func getTokenFromKeychain() -> String? {
        let keychain = Keychain(service: "user_token")

        guard let token = keychain["token"] else { return nil }

        return token
    }

    func loadMembers(completion: @escaping (Result<[ConcertMember], ConcertErrors>) -> Void) {
        guard let token = getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))}
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Content-Type": "application/json"
        ]
        AF.request(listConcertsUrl, headers: headers).validate(statusCode: 200..<300)
            .responseDecodable(of: [ConcertMember].self) { dataResponse in
            switch dataResponse.result {
            case .success(let concertMembers):
                completion(.success(concertMembers))
            case .failure(_):
                completion(.failure(.errorGetConcerts))
            }
        }
    }

    func loadMemberDetails(id: String, completion: @escaping (Result<ConcertMemberDetails, Error>) -> Void) {
        let stringId = "\(id).json"
        let membersURL = baseUrl.appendingPathComponent("members").appendingPathComponent(stringId)
        AF.request(membersURL).validate(statusCode: 200..<300).responseDecodable(of: ConcertMemberDetails.self) { dataResponse in
            switch dataResponse.result {
            case .success(let concertMemberDetails):
                completion(.success(concertMemberDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
