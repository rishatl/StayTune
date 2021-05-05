//
//  CouncilMemberCell.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit

class ConcertCell: UICollectionViewCell, ConcertCellView {
    var presenter: ConcertCellPresenter? {
        didSet {
            presenter?.setupCell()
        }
    }

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!

    func set(name: String) {
        nameLabel.text = name
    }

    func set(location: String) {
        locationLabel.text = location
    }

    func set(imageURL: URL?) {
        imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "No-Image-Placeholder"))
    }
}
