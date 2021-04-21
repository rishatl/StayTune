//
//  HollowButtonUtilities.swift
//  StayTuneApp
//
//  Created by Rishat on 22.03.2021.
//

import UIKit

class HollowButtonUtilities: NSObject {

    static func styleHollowButton(_ button: UIButton) {

        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1).cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
    }
}
