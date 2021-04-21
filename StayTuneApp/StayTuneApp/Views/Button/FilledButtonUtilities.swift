//
//  FilledButtonUtilities.swift
//  StayTuneApp
//
//  Created by Rishat on 22.03.2021.
//

import UIKit

class FilledButtonUtilities: NSObject {

    static func styleFilledButton(_ button: UIButton) {

        // Filled rounded corner style
        button.backgroundColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
    }
}
