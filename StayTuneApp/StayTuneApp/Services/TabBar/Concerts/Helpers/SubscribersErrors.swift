//
//  SubscribersErrors.swift
//  StayTuneApp
//
//  Created by Rishat on 14.05.2021.
//

import Foundation
import UIKit

enum SubscribersErrors: String, Error {
    case errorTokenSending = "Token didn't send"
    case errorGetSubscribers = "Couldn't get the list of subscribers"
    case errorGetFriends = "Couldn't get the list of friends"
    case errorGetFriend = "Couldn't get friend"
    case errorGetUser = "Couldn't get user"
}
