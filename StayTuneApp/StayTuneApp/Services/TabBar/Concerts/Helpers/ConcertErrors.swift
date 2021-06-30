//
//  ConcertErrors.swift
//  StayTuneApp
//
//  Created by Rishat on 29.04.2021.
//

import Foundation
import UIKit

enum ConcertErrors: String, Error {
    case errorTokenSending = "Token didn't send"
    case errorGetConcerts = "Couldn't get the list of concerts"
    case errorGetFavoriteConcerts = "Couldn't get the favorite list of concerts"
    case errorGetFavoriteConcert = "Couldn't get the favorite concert"
    case errorGetYourEvent = "Couldn't get your events"
    case errorGetConcert = "Couldn't get concert"
}
