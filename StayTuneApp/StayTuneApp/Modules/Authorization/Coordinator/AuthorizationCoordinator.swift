//
//  AuthorizationCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 10.03.2021.
//

import UIKit

class AuthorizationCoordinator {
    var navigationController = UINavigationController()

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func startController() -> UIViewController {
        let viewController: StartViewController = storyboard.instantiateViewController(identifier: "StartViewController")
        viewController.toSignUp = {
            self.navigationController.pushViewController(self.signUpController(), animated: true)
        }
        viewController.toLogin = {
            self.navigationController.pushViewController(self.loginController(), animated: true)
        }
        navigationController.pushViewController(viewController, animated: true)
        return navigationController
    }

    private func signUpController() -> UIViewController {
        let presenter = SignUpPresenter()
        let viewController: SignUpViewController = presenter.viewController()
        viewController.toHome = {
            self.navigationController.pushViewController(self.loginController(), animated: true)
        }
        return viewController
    }

    func loginController() -> UIViewController {
        let presenter = LoginPresenter()
        let viewController: LoginViewController = presenter.viewController()
        return viewController
    }
}
