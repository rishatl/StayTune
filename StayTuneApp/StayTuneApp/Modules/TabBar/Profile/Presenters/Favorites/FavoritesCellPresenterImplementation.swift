//
//  FavoritesCellPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 23.05.2021.
//

import Foundation

protocol FavoritesCellView: AnyObject {
    func set(city: String)
    func set(name: String)
    func set(image: URL?)
}

protocol FavoritesCellPresenter {
    func setupCell()
}

class FavoritesCellPresenterImplementation: FavoritesCellPresenter {
    weak var view: FavoritesCellView?
    var concert: Concert?

    func setupCell() {
        guard let view = view,
              let concert = concert
        else { return }
        view.set(city: concert.location)
        view.set(name: concert.name)
        view.set(image: concert.imageUrl)
    }
}
