//
//  TextFieldUtilities.swift
//  StayTuneApp
//
//  Created by Rishat on 22.03.2021.
//

import UIKit

class TextFieldUtilities: NSObject {

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
}
