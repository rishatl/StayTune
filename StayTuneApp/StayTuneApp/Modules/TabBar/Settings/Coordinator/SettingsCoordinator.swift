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
    let keychain = Keychain(service: "user_token")
    let storyboard = UIStoryboard(name: "AboutApp", bundle: nil)

    func settingsController() -> UIViewController {
        let viewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "gear"), tag: 0)
        viewController.toAuthorization = {
            self.keychain["id"] = nil
            self.keychain["token"] = nil
            self.keychain["username"] = nil
            self.keychain["email"] = nil
            self.keychain["city"] = nil
            self.keychain["telegram"] = nil
            self.keychain["image"] = nil
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.mainCoordinator?.start()
        }
        viewController.toEditProfile = {
            self.navigationController.pushViewController(self.editProfileController(), animated: true)
        }
        viewController.toAboutApp = {
            self.navigationController.pushViewController(self.aboutAppViewController(), animated: true)
        }
        self.navigationController.pushViewController(viewController, animated: true)
        return navigationController
    }

    func editProfileController() -> UIViewController {
        let presenter = EditProfilePresenter()
        let viewController: EditProfileViewController = presenter.viewController()
        return viewController
    }

    func aboutAppViewController() -> UIViewController {
        let viewController: AboutAppViewController = storyboard.instantiateViewController(withIdentifier: "AboutAppViewController") as! AboutAppViewController
        return viewController
    }
}
