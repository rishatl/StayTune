//
//  CouncilMemberCellPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation

protocol ConcertCellView: AnyObject {
    func set(name: String)
    func set(location: String)
    func set(imageURL: URL?)
}

protocol ConcertCellPresenter {
    func setupCell()
}

class ConcertCellPresenterImplementation: ConcertCellPresenter {
    weak var view: ConcertCellView?
    var concert: Concert?

    func setupCell() {
        guard let view = view,
              let concert = concert
        else { return }
        view.set(name: concert.name)
        view.set(location: concert.location)
        view.set(imageURL: concert.imageUrl)
    }
}
