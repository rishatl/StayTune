//
//  YourEventCell.swift
//  StayTuneApp
//
//  Created by Rishat on 22.05.2021.
//

import UIKit

class YourEventsCell: UITableViewCell, YourEventsCellView {

    var presenter: YourEventsCellPresenter? {
        didSet {
            presenter?.setupCell()
        }
    }

    @IBOutlet weak var concertImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(city: String) {
        cityLabel.text = city
    }

    func set(name: String) {
        nameLabel.text = name
    }

    func set(image: URL?) {
        concertImageView.kf.setImage(with: image, placeholder: UIImage(named: "No-Image-Placeholder"))
    }
}
