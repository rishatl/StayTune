//
//  RestFriendsService.swift
//  StayTuneApp
//
//  Created by Rishat on 14.05.2021.
//

import Foundation
import Alamofire
import UIKit
import KeychainAccess

protocol SubscribersService {
    func loadSubscribers(id: Int, completion: @escaping (Result<[Subscriber], SubscribersErrors>) -> Void)
    func loadUser(id: Int, completion: @escaping (Result<User, SubscribersErrors>) -> Void)
    func unsubscribe(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void)
    func updateSubscribers(id: Int, completion: @escaping (Result<[Subscriber], SubscribersErrors>) -> Void)
    func addFriend(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void)
    func unsubFriend(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void)
    func addFavorite(id: Int, completion: @escaping (Result<Void, ConcertErrors>) -> Void)
    func removeFavorite(id: Int, completion: @escaping (Result<Void, ConcertErrors>) -> Void)
}

class RestSubscribersService: SubscribersService {
    let subscribersUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/sub/byConcertId") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let userUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/users/user") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let unsubscribeUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/unsub/byConcertId") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let subUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/users/byConcertId") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    let addFriendUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/addFriend/byUserId") else {
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

    var addFavoriteUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/concerts/addFavorite") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    var removeFavoriteUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/concerts/removeFavorite") else {
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

    func loadSubscribers(id: Int, completion: @escaping (Result<[Subscriber], SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: subscribersUrl)

        AF.request(request).validate(statusCode: 200..<300)
            .responseDecodable(of: [Subscriber].self) { dataResponse in
                switch dataResponse.result {
                case .success(let subscribers):
                    completion(.success(subscribers))

                case .failure:
                    completion(.failure(.errorGetSubscribers))
                }
            }
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

    func unsubscribe(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: unsubscribeUrl)

        AF.request(request).validate(statusCode: 200..<300).response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))

                case .failure:
                    completion(.failure(.errorGetSubscribers))
                }
        }
    }

    func updateSubscribers(id: Int, completion: @escaping (Result<[Subscriber], SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: subUrl)

        AF.request(request).validate(statusCode: 200..<300)
            .responseDecodable(of: [Subscriber].self) { dataResponse in
                switch dataResponse.result {
                case .success(let subscribers):
                    completion(.success(subscribers))

                case .failure:
                    completion(.failure(.errorGetSubscribers))
                }
            }
    }

    func addFriend(id: Int, completion: @escaping (Result<Void, SubscribersErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: addFriendUrl)

        AF.request(request).validate(statusCode: 200..<300).response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))

                case .failure:
                    completion(.failure(.errorGetFriend))
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

    func addFavorite(id: Int, completion: @escaping (Result<Void, ConcertErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: addFavoriteUrl)

        AF.request(request).validate(statusCode: 200..<300).response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))

                case .failure:
                    completion(.failure(.errorGetFavoriteConcert))
                }
        }
    }

    func removeFavorite(id: Int, completion: @escaping (Result<Void, ConcertErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }

        let request = jsonRequest(token: token, id: id, url: removeFavoriteUrl)

        AF.request(request).validate(statusCode: 200..<300).response { dataResponse in
                switch dataResponse.result {
                case .success:
                    completion(.success(()))

                case .failure:
                    completion(.failure(.errorGetFavoriteConcert))
                }
        }
    }
}
