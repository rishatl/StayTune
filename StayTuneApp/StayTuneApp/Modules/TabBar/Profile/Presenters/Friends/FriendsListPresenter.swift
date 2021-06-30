//
//  FriendsListPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 21.05.2021.
//

import Foundation
import UIKit

protocol FriendsListView: UIViewController {
    func reloadData()
}

protocol FriendsListPresenter {
    var followSelected: ((Int) -> Void)? { get set }
    var friendsCount: Int { get }
    func viewDidLoad()
    func loadFriends()
    func unsubFriend(userId: Int)
    func friend(at indexPath: IndexPath) -> Subscriber
    func getFriends() -> [Subscriber]
    func didSelectSubscriber(at indexPath: IndexPath)
    func set(cell: FriendCell, with concert: Subscriber)
}

class FriendsListPresenterImplementation: FriendsListPresenter {

    var followSelected: ((Int) -> Void)?
    private let service: FriendsService
    private var cell: FriendCell?
    weak var view: FriendsListView?

    var friendsCount = 0

    private var friends: [Subscriber] = [] {
        didSet {
            friendsCount = friends.count
        }
    }

    init(service: FriendsService) {
        self.service = service
    }

    func viewDidLoad() {
        loadFriends()
    }

    func loadFriends() {
        service.loadFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.friends = friends
                self.view?.reloadData()

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func unsubFriend(userId: Int) {
        service.unsubFriend(id: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.cell?.updateFollowButton()
                for (index, var friend) in self.friends.enumerated() {
                    let id = friend.id
                    if  id == userId {
                        friend.isFriend = false
                        self.friends.remove(at: index)
                        break
                    }
                }
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func friend(at indexPath: IndexPath) -> Subscriber {
        friends[indexPath.item]
    }

    func getFriends() -> [Subscriber] {
        friends
    }

    func didSelectSubscriber(at indexPath: IndexPath) {
        service.loadUser(id: friends[indexPath.item].id) { [self] result in
            switch result {
            case .success(let user):
                guard let telegram = user.telegram else {
                    self.view?.alert(message: "Impossible to take telegram")
                    return
                }
                if user.isFriend == true {
                    self.view?.telegramAlert(message: telegram)
                } else {
                    self.view?.alert(message: "Not available. Subscribe to the user.")
                }

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func set(cell: FriendCell, with friend: Subscriber) {
        self.cell = cell
        let cellPresenter = FriendCellPresenterImplementation()
        cellPresenter.friend = friend
        cell.closure = unsubFriend(userId:)
        cellPresenter.view = cell
        cell.presenter = cellPresenter
    }
}
