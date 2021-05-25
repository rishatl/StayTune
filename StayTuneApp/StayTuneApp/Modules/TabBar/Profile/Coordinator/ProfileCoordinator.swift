//
//  ProfileCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 25.03.2021.
//

import Foundation
import UIKit

class ProfileCoordinator {
    var navigationController = UINavigationController()
    var mainCoordinator: MainCoordinator?
    private let storyboard = UIStoryboard(name: "Profile", bundle: nil)

    func profileController() -> UIViewController {
        let viewController: ProfileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        viewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person.crop.circle"), tag: 0)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
        return navigationController
    }

    func openConcertDetails(concert: ConcertDetails) {
        mainCoordinator?.openConcertDetails(concert: concert)
    }
}
