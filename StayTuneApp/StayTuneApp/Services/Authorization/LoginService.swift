//
//  LoginService.swift
//  StayTuneApp
//
//  Created by Rishat on 23.03.2021.
//

import Foundation
import UIKit
import Alamofire
import KeychainAccess

protocol LoginServiceProtocol {
    func login(login: String, password: String, completion: @escaping ((Result<(), AuthorizationErrors>) -> Void))
    func jsonConvert(login: String, password: String) -> Data?
}

class LoginService: LoginServiceProtocol {
    let mainUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/signIn") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    func jsonConvert(login: String, password: String) -> Data? {
        let jsonObject = NSMutableDictionary()

        jsonObject.setValue(login, forKey: "username")
        jsonObject.setValue(password, forKey: "password")

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

    func login(login: String, password: String, completion: @escaping ((Result<(), AuthorizationErrors>) -> Void)) {
        if login.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            completion(.failure(.errorEmptyFields))
            return
        }

        let cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordValid = PasswordValid()
        if passwordValid.isPasswordValid(cleanedPassword) == false {
            completion(.failure(.errorPasswordValid))
            return
        }

        let jsonData = jsonConvert(login: login, password: password)

        var request = URLRequest(url: mainUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(request).validate(statusCode: 200..<300).responseDecodable(of: UserResponse.self, decoder: decoder) { dataResponse in
            guard let value = dataResponse.value else {
                completion(.failure(.errorUserExist))
                return
            }
            let keychain = Keychain(service: "user_token")
            keychain["token"] = value.token
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.mainCoordinator?.userLogined()
            completion(.success(()))
        }
    }
}
