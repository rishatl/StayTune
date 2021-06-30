//
//  RestProfileService.swift
//  StayTuneApp
//
//  Created by Rishat on 21.05.2021.
//

import Foundation
import Alamofire
import UIKit
import KeychainAccess

protocol FriendsService {
    func loadUser(id: Int, completion: @escaping (Result<User, SubscribersErrors>) -> Void)
    func loadFriends(completion: @escaping (Result<[Subscriber], SubscribersErrors>) -> Void)
    func unsubFriend(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void)
}

class RestFriendsService: FriendsService {

    let userUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/users/user") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let friendsUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/users") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let unsubFriendUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/deleteFriend/byUserId") else {
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
            _ = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
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

    func loadUser(id: Int, completion: @escaping (Result<User, SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: userUrl)

        AF.request(request).validate(statusCode: 200..<300)
            .responseDecodable(of: User.self) { dataResponse in
                switch dataResponse.result {
                case .success(let user):
                    completion(.success(user))

                case .failure:
                    completion(.failure(.errorGetUser))
                }
            }
    }

    func loadFriends(completion: @escaping (Result<[Subscriber], SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let headers: HTTPHeaders = [
            "Authorization": token,
            "Content-Type": "application/json"
        ]

        var request = URLRequest(url: friendsUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.headers = headers

        AF.request(request).validate(statusCode: 200..<300)
            .responseDecodable(of: [Subscriber].self) { dataResponse in
                switch dataResponse.result {
                case .success(let subscribers):
                    completion(.success(subscribers))

                case .failure:
                    completion(.failure(.errorGetFriends))
                }
            }
    }

    func unsubFriend(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: unsubFriendUrl)

        AF.request(request).validate(statusCode: 200..<300).response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))

                case .failure:
                    completion(.failure(.errorGetFriend))
                }
        }
    }
}
