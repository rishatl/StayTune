//
//  LoginViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 10.03.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    var toHome: (() -> Void)?

    var presenter: LoginPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }

    func setUpElements() {
        errorLabel.alpha = 0
        TextFieldUtilities.styleTextField(loginTextField)
        TextFieldUtilities.styleTextField(passwordTextField)
        FilledButtonUtilities.styleFilledButton(loginButton)
    }

    @IBAction private func loginTapped(_ sender: Any) {
        let login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        presenter?.login(login: login, password: password)
    }

    func showError(_ message: String) {
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
        self.errorLabel.numberOfLines = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
                view.endEditing(true)
            }
            super.touchesBegan(touches, with: event)
    }
}
