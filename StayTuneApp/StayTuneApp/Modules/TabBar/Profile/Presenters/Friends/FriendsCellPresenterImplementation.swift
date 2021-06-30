//
//  FriendsCellPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 21.05.2021.
//

import Foundation

protocol FriendCellView: AnyObject {
    func set(email: String)
    func set(username: String)
    func set(image: String?)
}

protocol FriendCellPresenter {
    func setupCell()
}

class FriendCellPresenterImplementation: FriendCellPresenter {
    weak var view: FriendCellView?
    var friend: Subscriber?

    func setupCell() {
        guard let view = view,
              let friend = friend
        else { return }
        view.set(email: friend.email)
        view.set(username: friend.username)
        view.set(image: friend.image)
    }
}
