//
//  PageMenuViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 07.05.2021.
//

import UIKit

class PageMenuViewController: UIViewController {

    var pageMenu: CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        let controllerArray: [UIViewController] = []

        let pageMenuOptions: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .menuHeight(0),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: self.view.frame, pageMenuOptions: pageMenuOptions)
        self.view.addSubview(pageMenu!.view)
    }
}
