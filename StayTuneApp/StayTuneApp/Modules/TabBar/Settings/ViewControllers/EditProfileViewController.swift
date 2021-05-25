//
//  EditProfileViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 25.05.2021.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var telegramTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!

    var presenter: EditProfilePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    func setUpElements() {
        let profileImageDimension: CGFloat = 80
        imageView.layer.cornerRadius = profileImageDimension / 2

        TextFieldUtilities.styleTextField(emailTextField)
        TextFieldUtilities.styleTextField(cityTextField)
        TextFieldUtilities.styleTextField(telegramTextField)
        FilledButtonUtilities.styleFilledButton(saveBtn)
    }

    @IBAction private func saveTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let city = cityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let telegram = telegramTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        presenter?.editProfile(email: email, city: city, telegram: telegram)
    }
}
