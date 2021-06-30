//
//  FriendCell.swift
//  StayTuneApp
//
//  Created by Rishat on 21.05.2021.
//

import UIKit
import KeychainAccess

class FriendCell: UITableViewCell, FriendCellView {

    var presenter: FriendCellPresenter? {
        didSet {
            presenter?.setupCell()
            updateFollowButton()
        }
    }

    var closure: ((_ userId: Int) -> Void)?

    let keychain = Keychain(service: "user_token")

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(email: String) {
        emailLabel.text = email
    }

    func set(username: String) {
        usernameLabel.text = username
    }

    func set(image: String?) {
        let url: URL? = URL(string: image ?? "")
        avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "No-Image-Placeholder"))
    }

    var friend: Subscriber? {
        didSet {

            guard let friend = friend else {
                return
            }

            if friend.isFriend == true {
                updateFollowButton()
            }
        }
    }

    func updateFollowButton() {
        if friend?.isFriend == false {
            followButton.cornerRadius = 2
            followButton.borderWidth = 1
            followButton.borderColor = UIColor.ProfileSection.activeYellow
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(UIColor.ProfileSection.activeYellow, for: .normal)
        } else {
            followButton.borderWidth = 0
            followButton.cornerRadius = 0
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(UIColor.ProfileSection.inactiveWhite, for: .normal)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle("Unfollow", for: .normal)
    }

    @IBAction func clickedFollow(_ sender: UIButton) {
        closure?(sender.tag)
    }
}
