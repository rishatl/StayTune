//
//  UserInfoHeader.swift
//  StayTuneApp
//
//  Created by Rishat on 23.04.2021.
//

import UIKit
import KeychainAccess

class UserInfoHeader: UIView {

    let keychain = Keychain(service: "user_token")

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "No-Image-Placeholder")
        return iv
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        LabelUtilities.styleLabel(label)
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func viewDidLoad() {
        setUpView()
    }

    func getImage() -> String {
        guard let image = keychain["image"] else {
            return "Error get image"
        }
        return image
    }

    func setUpView() {
        let profileImageDimension: CGFloat = 80

        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        let image = keychain["image"]
        let url: URL? = URL(string: image ?? "")
        profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "No-Image-Placeholder"))

        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        usernameLabel.text = keychain["username"]

        addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 20).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        emailLabel.text = keychain["email"]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
