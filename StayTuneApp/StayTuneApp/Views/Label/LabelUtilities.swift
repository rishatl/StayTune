//
//  LabelUtilities.swift
//  StayTuneApp
//
//  Created by Rishat on 23.04.2021.
//

import UIKit

class LabelUtilities: NSObject {

    static func styleLabel(_ label: UILabel) {

        // Text Font
        label.font = UIFont.systemFont(ofSize: 25)

        label.translatesAutoresizingMaskIntoConstraints = false

        // Text Color
        label.textColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        // Tint Color
        label.tintColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
    }
}
