//
//  SettingsCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 25.03.2021.
//

import Foundation
import UIKit
import KeychainAccess

class SettingsCoordinator {
    var navigationController = UINavigationController()

    func settingsController() -> UIViewController {
        let viewController: SettingsViewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "gear"), tag: 0)
        viewController.toAuthorization = {
            let keychain = Keychain(service: "user_token")
            keychain["token"] = nil
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.mainCoordinator?.start()
        }
        self.navigationController.pushViewController(viewController, animated: true)
        return navigationController
    }
}
