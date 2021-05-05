//
//  CouncilconcertPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit
import Kingfisher

protocol ConcertView: AnyObject {
    func set(name: String)
    func set(location: String)
    func set(date: Date)
    func set(about: String)
    func set(singer: String)
    func set(singerURL: URL?)
    func set(price: Int)
    func set(imageURL: URL?)
}

protocol ConcertPresenter {
    func viewDidLoad()
    var toMaps: ((_ location: String, _ latitude: Double, _ longitude: Double) -> Void)? { get set }
}

class ConcertPresenterImplementation: ConcertPresenter {
    var concertDetails: ConcertDetails?
    weak var view: ConcertView?
    var toMaps: ((_ location: String, _ latitude: Double, _ longitude: Double) -> Void)?

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

    func viewDidLoad() {
        guard let concertDetails = concertDetails,
              let view = view
        else { return }
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
