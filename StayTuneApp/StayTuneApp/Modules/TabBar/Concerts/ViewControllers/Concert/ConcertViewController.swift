//
//  CouncilMemberViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit
import ExpandableLabel

enum SubState {
    case sub
    case unsub
}

enum FavState {
    case fav
    case unfav
}

class ConcertViewController: UIViewController, ConcertView {
    var presenter: ConcertPresenterImplementation?

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var aboutLabel: ExpandableLabel!
    @IBOutlet private var singerLabel: UILabel!
    @IBOutlet private var singerUrlLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    @IBOutlet private var mapsButton: UIButton!
    @IBOutlet private var subscribeButton: UIButton!

    private var subState: SubState = .unsub
    private var favState: FavState = .unfav

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setUpElements()
    }

    func setUpElements() {
        if favState == .unfav {
            if #available(iOS 13.0, *) {
                let favoriteButtonImage = UIImage(systemName: "star")
                let favoriteButton = UIBarButtonItem(image: favoriteButtonImage, style: .plain, target: self, action: #selector(favoriteTapped))
                navigationItem.rightBarButtonItem = favoriteButton
            } else {
                // Doesn't work
                let favoriteButtonImage = UIImage(named: "star")
                let favoriteButton = UIBarButtonItem(image: favoriteButtonImage, style: .plain, target: self, action: #selector(favoriteTapped))
                navigationItem.rightBarButtonItem = favoriteButton
            }
        }
        FilledButtonUtilities.styleFilledButton(mapsButton)
        FilledButtonUtilities.styleFilledButton(subscribeButton)
//                aboutLabel.numberOfLines = 3
//                aboutLabel.collapsed = true
//                aboutLabel.collapsedAttributedLink = NSAttributedString(string: "More")
//                aboutLabel.setLessLinkWith(lessLink: "Close", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)], position: nil)
//                aboutLabel.expandedAttributedLink = NSAttributedString(string: "Less")
    }

    func set(name: String) {
        nameLabel.text = name
    }

    func set(date: Date) {
        dateLabel.text = DateFormatter.getStringFromDate(date)
    }

    func set(location: String) {
        locationLabel.text = location
    }

    func set(about: String) {
        aboutLabel.text = about
    }

    func set(singer: String) {
        singerLabel.text = singer
    }

    func set(singerURL singerUrl: URL?) {
        singerUrlLabel.text = singerUrl?.absoluteString
    }

    func set(price: Int) {
        priceLabel.text = String(price) + "Rub"
    }

    func set(imageURL: URL?) {
        imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "No-Image-Placeholder"))
    }

    func getSubState() -> SubState {
        return subState
    }

    func getFavState() -> FavState {
        return favState
    }

    func changeSubscribe() {
        switch subState {
        case .unsub:
            subscribeButton.setTitle("Unsubscribe", for: .normal)
            subState = .sub

        case .sub:
            subscribeButton.setTitle("Subscribe", for: .normal)
            subState = .unsub
        }
    }

    func changeFavState() {
        switch favState {
        case .fav:
            if #available(iOS 13.0, *) {
                let favoriteButtonImage = UIImage(systemName: "star")
                let favoriteButton = UIBarButtonItem(image: favoriteButtonImage, style: .plain, target: self, action: #selector(favoriteTapped))
                navigationItem.rightBarButtonItem = favoriteButton
                favState = .unfav
            } else {
                // Doesn't work
                let favoriteButtonImage = UIImage(named: "star")
                let favoriteButton = UIBarButtonItem(image: favoriteButtonImage, style: .plain, target: self, action: #selector(favoriteTapped))
                navigationItem.rightBarButtonItem = favoriteButton
                favState = .unfav
            }

        case .unfav:
            if #available(iOS 13.0, *) {
                let favoriteButtonImage = UIImage(systemName: "star.fill")
                let favoriteButton = UIBarButtonItem(image: favoriteButtonImage, style: .plain, target: self, action: #selector(favoriteTapped))
                navigationItem.rightBarButtonItem = favoriteButton
                favState = .fav
            } else {
                // Doesn't work
                let favoriteButtonImage = UIImage(named: "star.fill")
                let favoriteButton = UIBarButtonItem(image: favoriteButtonImage, style: .plain, target: self, action: #selector(favoriteTapped))
                navigationItem.rightBarButtonItem = favoriteButton
                favState = .fav
            }
        }
    }

    @objc public func favoriteTapped() {
        presenter?.pressFavButton()
    }

    @IBAction func mapsTapped(_ sender: Any) {
        presenter?.toMaps?((presenter?.getLocation())!, (presenter?.getLatitude())!, (presenter?.getLongitude())!)
    }

    @IBAction private func subscribe(_ sender: Any) {
        presenter?.pressSubButton(isNeedSubscribe: true)
    }

    @IBAction private func showSubs(_ sender: Any) {
        presenter?.pressSubButton(isNeedSubscribe: false)
    }
}
