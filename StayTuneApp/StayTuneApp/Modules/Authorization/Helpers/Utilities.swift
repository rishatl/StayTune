//
//  Utilities.swift
//  StayTuneApp
//
//  Created by Rishat on 14.03.2021.
//

import UIKit

class Utilities: NSObject {

    static func styleTextField(_ textfield: UITextField) {

        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)

        bottomLine.backgroundColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1).cgColor

        // Remove border on text field
        textfield.borderStyle = .none

        // Text Color
        textfield.textColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        // Tint Color
        textfield.tintColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }

    static func styleFilledButton(_ button: UIButton) {

        // Filled rounded corner style
        button.backgroundColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
    }

    static func styleHollowButton(_ button: UIButton) {

        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1).cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
    }

    static func isPasswordValid(_ password: String) -> Bool {

        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
