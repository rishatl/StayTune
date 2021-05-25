//
//  CouncilconcertPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit
import Kingfisher
import KeychainAccess

protocol ConcertView: UIViewController {
    func set(name: String)
    func set(location: String)
    func set(date: Date)
    func set(about: String)
    func set(singer: String)
    func set(singerURL: URL?)
    func set(price: Int)
    func set(imageURL: URL?)
    func changeSubscribe()
    func changeFavState()
    func getSubState() -> SubState
    func getFavState() -> FavState
}

protocol ConcertPresenter {
    func viewDidLoad()
    var toMaps: ((_ location: String, _ latitude: Double, _ longitude: Double) -> Void)? { get set }
    var toSubscribers: ((_ concertId: Int, _ flag: Bool) -> Void)? { get set }
}

class ConcertPresenterImplementation: ConcertPresenter {

    var concertDetails: ConcertDetails?
    weak var view: ConcertView?
    private let service: SubscribersService

    let keychain = Keychain(service: "user_token")

    var toMaps: ((_ location: String, _ latitude: Double, _ longitude: Double) -> Void)?
    var toSubscribers: ((_ concertId: Int, _ flag: Bool) -> Void)?

    init(service: SubscribersService) {
        self.service = service
    }

    func getLocation() -> String? {
        guard let location = concertDetails?.location else { return nil }
        return location
    }

    func getLatitude() -> Double? {
        guard let latitude = concertDetails?.latitude else { return nil }
        return latitude
    }

    func getLongitude() -> Double? {
        guard let longitude = concertDetails?.longitude else { return nil }
        return longitude
    }

    func getConcertId() -> Int? {
        guard let concertId = concertDetails?.id else { return nil }
        return concertId
    }

    func pressSubButton(isNeedSubscribe: Bool) {
        guard let id = concertDetails?.id, let state = self.view?.getSubState() else { return }
        switch state {
        case .sub:
            if isNeedSubscribe {
                unsubscribe(id: id)
            } else {
                toSubscribers!(id, isNeedSubscribe)
            }

        case .unsub:
            toSubscribers!(id, isNeedSubscribe)
        }
    }

    func unsubscribe(id: Int) {
        service.unsubscribe(id: id) { [self] result in
            switch result {
            case .success:
                self.view?.changeSubscribe()

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func getId() -> Int? {
        guard let id = Int(keychain["id"]!) else { return nil }
        return id
    }

    func pressFavButton() {
        guard let id = concertDetails?.id, let state = self.view?.getFavState() else { return }
        switch state {
        case .fav:
            removeFavorite(concertId: id)

        case .unfav:
            addFavorite(concertId: id)
        }
    }

    func addFavorite(concertId: Int) {
        service.addFavorite(id: concertId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.view?.changeFavState()

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func removeFavorite(concertId: Int) {
        service.removeFavorite(id: concertId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.view?.changeFavState()

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func viewDidLoad() {
        guard let concertDetails = concertDetails,
              let view = view
        else { return }
        if concertDetails.subscribers.contains(where: { user in
            if user.username == self.keychain["username"] {
                return true
            }
            return false
        }) {
            self.view?.changeSubscribe()
        }

        if concertDetails.userLiked.contains(where: { user in
            if user.username == self.keychain["username"] {
                return true
            }
            return false
        }) {
            self.view?.changeFavState()
        }
        view.set(name: concertDetails.name)
        view.set(location: concertDetails.location)
        view.set(date: concertDetails.date)
        view.set(about: concertDetails.about)
        view.set(singer: concertDetails.singer)
        view.set(singerURL: concertDetails.singerUrl)
        view.set(price: concertDetails.price)
        view.set(imageURL: concertDetails.imageUrl)
    }
}
