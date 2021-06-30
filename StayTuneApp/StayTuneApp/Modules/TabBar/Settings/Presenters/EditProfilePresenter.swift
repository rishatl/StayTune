//
//  EditProfilePresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 25.05.2021.
//

import Foundation
import UIKit
import KeychainAccess

class EditProfilePresenter {
    private let editService: EditProfileService
    private weak var view: EditProfileViewController!
    let keychain = Keychain(service: "user_token")

    init(editService: EditProfileServiceProtocol = EditProfileService()) {
        self.editService = editService as! EditProfileService
    }

    func viewDidLoad() {
        let image = keychain["image"]
        let url: URL? = URL(string: image ?? "")
        self.view?.imageView.kf.setImage(with: url, placeholder: UIImage(named: "No-Image-Placeholder"))
        self.view?.title = "Edit Profile"
    }

    func editProfile(email: String, city: String, telegram: String) {
        editService.editProfile(email: email, city: city, telegram: telegram) { result in
            switch result {
            case .success:
                if self.view?.emailTextField.text?.isEmpty != true {
                    self.keychain["email"] = self.view?.emailTextField.text
                }
                if self.view?.cityTextField.text?.isEmpty != true {
                    self.keychain["city"] = self.view?.cityTextField.text
                }
                if self.view?.telegramTextField.text?.isEmpty != true {
                    self.keychain["telegram"] = self.view?.telegramTextField.text
                }
                self.view?.navigationController?.popViewController(animated: false)

            case let .failure(error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func getImage() -> String {
        guard let image = keychain["image"] else {
            return "Error get image"
        }
        return image
    }

    func viewController() -> EditProfileViewController {
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let controller: EditProfileViewController = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        controller.presenter = self
        view = controller
        return controller
    }
}
