//
//  MainCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 24.03.2021.
//

import Foundation
import UIKit

class MainCoordinator {
    let window: UIWindow
    let loginService: LoginService
    var authorizationCoordinator: AuthorizationCoordinator
    var concertsCoordinator: ConcertsCoordinator
    var settingsCoordinator: SettingsCoordinator
    var profileCoordinator: ProfileCoordinator

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
//        window.rootViewController = authorizationCoordinator.startController()
//        authorizationCoordinator.navigationController.popToRootViewController(animated: false)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [settingsCoordinator.settingsController(), concertsCoordinator.concertsController(), profileCoordinator.profileController()]
        window.rootViewController = tabBarController
    }

    func userLogined() {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [settingsCoordinator.settingsController(), concertsCoordinator.concertsController(), profileCoordinator.profileController()]
        window.rootViewController = tabBarController
        settingsCoordinator.navigationController.popToRootViewController(animated: false)
    }
}
