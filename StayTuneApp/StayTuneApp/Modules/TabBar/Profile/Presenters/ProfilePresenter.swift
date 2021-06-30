//
//  ProfilePresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 25.05.2021.
//

import UIKit
import KeychainAccess

final class ProfilePresenter {

    // MARK: Public properties

    weak var view: ProfileViewController?
    let keychain = Keychain(service: "user_token")

    // MARK: Private properties

    private let profileService: ProfileServiceProtocol = ProfileService()

    // MARK: Public

    func viewDidLoad() {
        view?.username.text = keychain["username"]
        view?.city.text = setUpCity()
        guard let strImage = keychain["image"] else {
            return
        }
        guard let url = URL(string: strImage) else {
            self.view?.alert(message: "URL error")
            return
        }
        guard let view = view else {
            return
        }
        view.updatePhoto(url: url)
    }

    func setUpCity() -> String {
        guard let city = keychain["city"] else { return "City" }
        return city
    }

    func viewTelegram() -> String? {
        keychain["telegram"]
    }

    func changePhoto(image: UIImage) {
        profileService.changePhoto(image: image) { [weak self] result in

            guard let self = self else { return }

            switch result {

            case .success(let imagePath):
                guard let url = URL(string: imagePath) else {
                    self.view?.alert(message: "URL error")
                    return
                }
                self.view?.updatePhoto(url: url)
                let path = try? String(contentsOf: url)
                self.keychain["image"] = path

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }
}
