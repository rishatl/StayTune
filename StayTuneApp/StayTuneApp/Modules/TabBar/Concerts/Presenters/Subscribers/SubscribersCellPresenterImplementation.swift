//
//  SubscribersCellPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 14.05.2021.
//

import Foundation

protocol SubscriberCellView: AnyObject {
    func set(email: String)
    func set(username: String)
    func set(image: String?)
}

protocol SubscriberCellPresenter {
    func setupCell()
}

class SubscriberCellPresenterImplementation: SubscriberCellPresenter {
    weak var view: SubscriberCellView?
    var subscriber: Subscriber?

    func setupCell() {
        guard let view = view,
              let subscriber = subscriber
        else { return }
        view.set(email: subscriber.email)
        view.set(username: subscriber.username)
        view.set(image: subscriber.image)
    }
}
