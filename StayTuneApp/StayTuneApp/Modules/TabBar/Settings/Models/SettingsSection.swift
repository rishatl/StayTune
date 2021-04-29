//
//  SettingsSection.swift
//  StayTuneApp
//
//  Created by Rishat on 23.04.2021.
//
import UIKit

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social
    case Communications

    var description: String {
        switch self {
        case .Social:
            return "Social"
        case .Communications:
            return "Communications"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType {
    case editProfile
    case logOut

    var containsSwitch: Bool { return false }

    var description: String {
        switch self {
        case .editProfile:
            return "Edit Profile"
        case .logOut:
            return "Log Out"
        }
    }
}

enum CommunicationsOptions: Int, CaseIterable, SectionType {
    case notifications
    case aboutApp

    var containsSwitch: Bool {
        switch self {
        case .notifications:
            return true
        case .aboutApp:
            return false
        }
    }

    var description: String {
        switch self {
        case .notifications:
            return "Notifications"
        case .aboutApp:
            return "About App"
        }
    }
}
