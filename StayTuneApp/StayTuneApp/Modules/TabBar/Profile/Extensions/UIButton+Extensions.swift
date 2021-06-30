//
//  UIButton+Extensions.swift
//  StayTuneApp
//
//  Created by Rishat on 07.05.2021.
//

import UIKit

extension UIButton {
    func update_ProfileMenuStateFor(isSelected: Bool) {
        if isSelected {
            setTitleColor(UIColor.ProfileSection.menuItemSelected, for: .normal)
        } else {
            setTitleColor(UIColor.ProfileSection.menuItemDeselected, for: .normal)
        }
    }
}
