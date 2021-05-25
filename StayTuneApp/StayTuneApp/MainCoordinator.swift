//
//  MainCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 24.03.2021.
//

import Foundation
import UIKit
import KeychainAccess

class MainCoordinator {
    let window: UIWindow
    let loginService: LoginService
    var authorizationCoordinator: AuthorizationCoordinator
    var concertsCoordinator: ConcertsCoordinator
    var settingsCoordinator: SettingsCoordinator
    var profileCoordinator: ProfileCoordinator
    let tabBarController = UITabBarController()

    init(loginService: LoginService = LoginService()) {
        authorizationCoordinator = AuthorizationCoordinator()
        concertsCoordinator = ConcertsCoordinator()
        settingsCoordinator = SettingsCoordinator()
        profileCoordinator = ProfileCoordinator()
        self.loginService = loginService
        window = UIWindow(frame: UIScreen.main.bounds )
        window.makeKeyAndVisible()
    }

    func start() {
        profileCoordinator.mainCoordinator = self
        let keychain = Keychain(service: "user_token")
        if keychain["token"] == nil {
            window.rootViewController = authorizationCoordinator.startController()
            authorizationCoordinator.navigationController.popToRootViewController(animated: true)
        } else {
            tabBarController.viewControllers = [settingsCoordinator.settingsController(), concertsCoordinator.concertsController(), profileCoordinator.profileController()]
            window.rootViewController = tabBarController
        }
    }

    func userLogined() {
        tabBarController.viewControllers = [settingsCoordinator.settingsController(), concertsCoordinator.concertsController(), profileCoordinator.profileController()]
        window.rootViewController = tabBarController
        settingsCoordinator.navigationController.popToRootViewController(animated: false)
    }

    func openConcertDetails(concert: ConcertDetails) {
        tabBarController.selectedIndex = 1
        concertsCoordinator.showConcertDetails(concert: concert)
    }
}
