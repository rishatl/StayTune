//
//  AuthorizationErrors.swift
//  StayTuneApp
//
//  Created by Rishat on 25.03.2021.
//

import Foundation
import UIKit

enum AuthorizationErrors: String, Error {
    case errorCreateUser = "Error creating user"
    case errorUserExist = "User is doesn't exist"
    case errorSaveDataUser = "Error saving user data"
    case errorEmptyFields = "Please fill in all fields"
    case errorPasswordValid = "Please make sure your password is at least 8 characters, contains a special character and a number"
}
