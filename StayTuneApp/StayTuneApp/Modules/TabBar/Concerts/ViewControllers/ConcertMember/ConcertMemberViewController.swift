//
//  CouncilMemberViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit

class ConcertMemberViewController: UIViewController, ConcertMemberView {
    var presenter: ConcertMemberPresenter?

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var rankLabel: UILabel!
    @IBOutlet private var bioLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    func set(name: String) {
        nameLabel.text = name
    }

    func set(bio: String) {
        bioLabel.text = bio
    }

    func set(rank: String) {
        rankLabel.text = rank
    }

    func set(imageURL: URL?) {
        imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "No-Image-Placeholder"))
    }
}
