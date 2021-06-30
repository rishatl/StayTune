//
//  PasswordValid.swift
//  StayTuneApp
//
//  Created by Rishat on 25.03.2021.
//

import Foundation
import UIKit

class PasswordValid {
    func isPasswordValid(_ password: String) -> Bool {

        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
