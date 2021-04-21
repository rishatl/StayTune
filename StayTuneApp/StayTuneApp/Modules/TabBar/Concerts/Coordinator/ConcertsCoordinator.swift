//
//  ConcertsCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 24.03.2021.
//

import Foundation
import UIKit

class ConcertsCoordinator {
    var navigationController = UINavigationController()
    private let storyboard = UIStoryboard(name: "Concerts", bundle: nil)

    func concertsController() -> UIViewController {
        let viewController: ConcertsViewController = storyboard.instantiateViewController(identifier: "ConcertsViewController")
        viewController.tabBarItem = UITabBarItem(title: "Concerts", image: UIImage(named: "calendar"), tag: 0)
        self.navigationController.pushViewController(viewController, animated: true)
        return navigationController
    }
}
