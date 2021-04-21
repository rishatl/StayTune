//
//  LoginPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 23.03.2021.
//

import Foundation
import UIKit

class LoginPresenter {
    private let loginService: LoginServiceProtocol
    private weak var view: LoginViewController!

    init(loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
    }

    func login(login: String, password: String) {
        loginService.login(login: login, password: password) { result in
            switch result {
            case .success:
                guard let toHome = self.view.toHome else {
                    return
                }
                toHome()

            case let .failure(error):
                self.view.showError(error.rawValue)
            }
        }
    }

    func viewController() -> LoginViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller: LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
            controller.presenter = self
            view = controller
            return controller
    }
}
