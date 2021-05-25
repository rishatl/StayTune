//
//  SignUpPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 16.03.2021.
//

import Foundation
import UIKit

class SignUpPresenter {
    private let signUpService: SignUpServiceProtocol
    private weak var view: SignUpViewController!

    init(signUpService: SignUpServiceProtocol = SignUpService()) {
        self.signUpService = signUpService
    }

    func authorize(login: String, username: String, password: String) {
        signUpService.authorize(login: login, username: username, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
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

    func viewController() -> SignUpViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: SignUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            controller.presenter = self
            view = controller
            return controller
    }
}
