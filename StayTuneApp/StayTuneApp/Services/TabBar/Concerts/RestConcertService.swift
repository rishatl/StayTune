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
    func loadConcerts(completion: @escaping (Result<[Concert], ConcertErrors>) -> Void)
    func loadConcertDetails(id: Int, completion: @escaping (Result<ConcertDetails, ConcertErrors>) -> Void)
}

class RestConcertService: ConcertService {

    let listConcertsUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/concerts") else {
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

    func loadConcerts(completion: @escaping (Result<[Concert], ConcertErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Content-Type": "application/json"
        ]
        AF.request(listConcertsUrl, headers: headers).validate(statusCode: 200..<300)
            .responseDecodable(of: [Concert].self) { dataResponse in
            switch dataResponse.result {
            case .success(let concerts):
                completion(.success(concerts))
            case .failure(_):
                completion(.failure(.errorGetConcerts))
            }
        }
    }

    func jsonConvert(id: Int) -> Data? {
        let jsonObject = NSMutableDictionary()

        jsonObject.setValue(id, forKey: "id")

        let jsonData: Data

        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as Data
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            print("json string = \(jsonString)")
            return jsonData
        } catch _ {
            print("JSON failure convert")
            return nil
        }
    }

    func loadConcertDetails(id: Int, completion: @escaping (Result<ConcertDetails, ConcertErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Content-Type": "application/json"
        ]

        let jsonData = jsonConvert(id: id)

        var request = URLRequest(url: concertUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = headers
        request.httpBody = jsonData

        AF.request(request).validate(statusCode: 200..<300).responseDecodable(of: ConcertDetails.self) { dataResponse in
            switch dataResponse.result {
            case .success(let concertsDetails):
                completion(.success(concertsDetails))
            case .failure(_):
                completion(.failure(.errorGetConcert))
            }
        }
    }
}
