//
//  UIView+Extensions.swift
//  StayTuneApp
//
//  Created by Rishat on 07.05.2021.
//

import UIKit

extension UIView {

    func update_DotStateFor(isSelected: Bool) {
        if isSelected {
            backgroundColor = UIColor.ProfileSection.menuDotSelected
        } else {
            backgroundColor = UIColor.ProfileSection.menuDotDeselected
        }
    }
}
