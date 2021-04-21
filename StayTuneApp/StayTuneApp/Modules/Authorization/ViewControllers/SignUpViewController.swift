//
//  SignUpViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 10.03.2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    var toHome: (() -> Void)?

    var presenter: SignUpPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }

    func setUpElements() {
        errorLabel.alpha = 0
        TextFieldUtilities.styleTextField(loginTextField)
        TextFieldUtilities.styleTextField(nameTextField)
        TextFieldUtilities.styleTextField(passwordTextField)
        FilledButtonUtilities.styleFilledButton(signUpButton)
    }

    @IBAction private func signUpTapped(_ sender: Any) {
        let login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        presenter?.authorize(login: login, username: username, password: password)
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        self.errorLabel.numberOfLines = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
                view.endEditing(true)
            }
            super.touchesBegan(touches, with: event)
    }
}
