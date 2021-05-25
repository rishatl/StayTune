//
//  RestYourEventsService.swift
//  StayTuneApp
//
//  Created by Rishat on 23.05.2021.
//

import Foundation
import Alamofire
import UIKit
import KeychainAccess

protocol YourEventsService {
    func loadConcerts(id: Int, completion: @escaping (Result<[Concert], ConcertErrors>) -> Void)
    func loadConcertDetails(id: Int, completion: @escaping (Result<ConcertDetails, ConcertErrors>) -> Void)
}

class RestYourEventsService: YourEventsService {

    let listConcertsUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/concerts/byUserId") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let concertUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/concert/byConcertId") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    func jsonConvert(id: Int) -> Data? {
        let jsonObject = NSMutableDictionary()

        jsonObject.setValue(id, forKey: "id")

        let jsonData: Data

        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as Data
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            return jsonData
        } catch _ {
            return nil
        }
    }

    func jsonRequest(token: String, id: Int, url: URL) -> URLRequest {
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Content-Type": "application/json"
        ]

        let jsonData = jsonConvert(id: id)

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = headers
        request.httpBody = jsonData

        return request
    }

    func loadConcerts(id: Int, completion: @escaping (Result<[Concert], ConcertErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: listConcertsUrl)

        AF.request(request).validate(statusCode: 200..<300)
            .responseDecodable(of: [Concert].self) { dataResponse in
            switch dataResponse.result {
            case .success(let concerts):
                completion(.success(concerts))

            case .failure:
                completion(.failure(.errorGetYourEvent))
            }
            }
    }

    func loadConcertDetails(id: Int, completion: @escaping (Result<ConcertDetails, ConcertErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: concertUrl)

        AF.request(request).validate(statusCode: 200..<300).responseDecodable(of: ConcertDetails.self) { dataResponse in
            switch dataResponse.result {
            case .success(let concertsDetails):
                completion(.success(concertsDetails))

            case .failure:
                completion(.failure(.errorGetConcert))
            }
        }
    }
}
