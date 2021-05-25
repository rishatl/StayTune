//
//  EditProfileService.swift
//  StayTuneApp
//
//  Created by Rishat on 25.05.2021.
//

import Foundation
import UIKit
import Alamofire
import KeychainAccess

protocol EditProfileServiceProtocol {
    func editProfile(email: String, city: String, telegram: String, completion: @escaping ((Result<Void, EditProfileErrors>) -> Void))
    func jsonConvert(email: String, city: String, telegram: String) -> Data?
}

class EditProfileService: EditProfileServiceProtocol {
    let mainUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/users/user/edit") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    func jsonConvert(email: String, city: String, telegram: String) -> Data? {
        let jsonObject = NSMutableDictionary()

        jsonObject.setValue(email, forKey: "email")
        jsonObject.setValue(city, forKey: "city")
        jsonObject.setValue(telegram, forKey: "telegram")

        let jsonData: Data

        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as Data
            _ = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            return jsonData
        } catch _ {
            return nil
        }
    }

    func editProfile(email: String, city: String, telegram: String, completion: @escaping ((Result<Void, EditProfileErrors>) -> Void)) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }
        let headers: HTTPHeaders = [
            "Authorization": token,
            "Content-Type": "application/json"
        ]

        let jsonData = jsonConvert(email: email, city: city, telegram: telegram)

        var request = URLRequest(url: mainUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = headers
        request.httpBody = jsonData

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(request).validate(statusCode: 200..<300).response { dataResponse in
            completion(.success(()))
        }
    }
}
