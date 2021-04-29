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
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
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
        spinnerActived()

        let login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        presenter?.login(login: login, password: password)
    }

    func spinnerActived() {
        errorLabel.alpha = 0
        spinner.isHidden = false
        loginTextField.isHidden = true
        passwordTextField.isHidden = true
        loginButton.isHidden = true
    }

    func spinnerNonActived() {
        spinner.isHidden = true
        loginTextField.isHidden = false
        passwordTextField.isHidden = false
        loginButton.isHidden = false
    }

    func showError(_ message: String) {
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
        self.errorLabel.numberOfLines = 0

        spinnerNonActived()
    }
}
