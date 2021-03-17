//
//  StartViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 28.02.2021.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!

    var toSignUp: (() -> Void)?
    var toLogin: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }

    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

    @IBAction private func signUp(_ sender: Any) {
        toSignUp?()
    }

    @IBAction private func loginTapped(_ sender: Any) {
        toLogin?()
    }

//    private func login() {
//        toLogin?()
//    }
//
//    private func signUp() {
//        toSignUp?()
//    }
}
