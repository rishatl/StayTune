//
//  ProfileErrors.swift
//  StayTuneApp
//
//  Created by Rishat on 25.05.2021.
//

import Foundation
import UIKit

enum ProfileErrors: String, Error {
    case errorTokenSending = "Token didn't send"
    case errorGetImage = "Couldn't get the image"
}
