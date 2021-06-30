//
//  ProfileService.swift
//  StayTuneApp
//
//  Created by Rishat on 25.05.2021.
//

import Alamofire
import KeychainAccess
import UIKit

protocol ProfileServiceProtocol {
    func changePhoto(image: UIImage, completion: @escaping (Result<String, ProfileErrors>) -> Void)
}

final class ProfileService: ProfileServiceProtocol {

    let keychain = Keychain(service: "user_token")

    let changePhotoUrl: URL = {
        guard let url = URL(string: "http://localhost:8080/changePhoto") else {
            fatalError("Could not create base url")
        }
        return url
    }()

    func changePhoto(image: UIImage, completion: @escaping (Result<String, ProfileErrors>) -> Void) {
        let keychainService = KeychainService()
        guard let token = keychainService.getTokenFromKeychain() else { return completion(.failure(.errorTokenSending))
        }
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": token
        ]
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }

        let multipartFormData = MultipartFormData()
        multipartFormData.append(data, withName: "image_file", fileName: "image.jpeg", mimeType: "image/jpeg")

        AF.upload(
            multipartFormData: multipartFormData,
            to: changePhotoUrl,
            headers: headers
        )
        .responseDecodable(of: ImageSuccessResponse.self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response.imagePath))
                self.keychain["image"] = response.imagePath

            case .failure:
                return completion(.failure(.errorGetImage))
            }
        }
    }
}

struct ImageSuccessResponse: Codable {
    let imagePath: String
}
