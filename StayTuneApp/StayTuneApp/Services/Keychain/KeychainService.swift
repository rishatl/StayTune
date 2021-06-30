//
//  KeychainService.swift
//  StayTuneApp
//
//  Created by Rishat on 02.05.2021.
//

import Foundation
import UIKit
import KeychainAccess

protocol KeychainServiceProtocol {
    func getTokenFromKeychain() -> String?
}

class KeychainService: KeychainServiceProtocol {
    func getTokenFromKeychain() -> String? {
        let keychain = Keychain(service: "user_token")

        guard let token = keychain["token"] else { return nil }

        return token
    }
}
