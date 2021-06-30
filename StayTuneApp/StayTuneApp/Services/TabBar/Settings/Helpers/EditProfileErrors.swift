//
//  EditProfileErrors.swift
//  StayTuneApp
//
//  Created by Rishat on 26.05.2021.
//

import Foundation
import UIKit

enum EditProfileErrors: String, Error {
    case errorEditUser = "Error edit user"
    case errorTokenSending = "Token didn't send"
}
