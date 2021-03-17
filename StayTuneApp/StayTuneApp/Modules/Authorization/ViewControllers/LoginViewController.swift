//
//  LoginViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 10.03.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    var toHome: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }

    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(loginTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    @IBAction private func loginTapped(_ sender: Any) {
        let login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                self.errorLabel.numberOfLines = 0
            } else {
                self.toHome?()
            }
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if (touches.first) != nil {
//                view.endEditing(true)
//            }
//            super.touchesBegan(touches, with: event)
//    }

//    private func login() {
//        toLogin?()
//    }
}
