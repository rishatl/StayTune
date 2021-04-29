//
//  CouncilMemberCell.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit

class ConcertMemberCell: UICollectionViewCell, ConcertMemberCellView {
    var presenter: ConcertMemberCellPresenter? {
        didSet {
            presenter?.setupCell()
        }
    }

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var rankLabel: UILabel!

    func set(name: String) {
        nameLabel.text = name
    }

    func set(rank: String) {
        rankLabel.text = rank
    }

    func set(imageURL: URL?) {
        imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "No-Image-Placeholder"))
    }
}
