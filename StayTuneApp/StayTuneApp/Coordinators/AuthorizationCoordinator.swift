//
//  AuthorizationCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 10.03.2021.
//

import UIKit

class AuthorizationCoordinator {
    func startViewController() -> UIViewController {
        UINavigationController(rootViewController: startController())
    }

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    private func startController() -> UIViewController {
        let viewController: StartViewController = storyboard.instantiateViewController(identifier: "StartViewController")
        viewController.toSignUp = { [weak viewController] in
            viewController?.navigationController?.pushViewController(self.signUpController(), animated: true)
        }
        viewController.toLogin = { [weak viewController] in
            viewController?.navigationController?.pushViewController(self.loginController(), animated: true)
        }
        return viewController
    }

    private func signUpController() -> UIViewController {
        let viewController: SignUpViewController = storyboard.instantiateViewController(identifier: "SignUpViewController")
        viewController.toHome = { [weak viewController] in
//            let twitterController = TwitterCoordinator().startViewController()
//            viewController?.navigationController?.pushViewController(twitterController, animated: true)
            viewController?.navigationController?.pushViewController(self.homeController(), animated: true)
        }
        return viewController
    }

    private func loginController() -> UIViewController {
        let viewController: LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
        viewController.toHome = { [weak viewController] in
            viewController?.navigationController?.pushViewController(self.homeController(), animated: true)
        }
        return viewController
    }

    private func homeController() -> UIViewController {
        let viewController: HomeViewController = storyboard.instantiateViewController(identifier: "HomeViewController")
        return viewController
    }
}
