//
//  SubscriberListPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 14.05.2021.
//

import Foundation
import UIKit

protocol SubscribersListView: UIViewController {
    func reloadData()
}

protocol SubscribersListPresenter {
    var followSelected: ((Int) -> Void)? { get set }
    var successSubscribe: (() -> Void)? { get set }
    var subscribersCount: Int { get }
    var friendsCount: Int { get }
    func loadSubscribers()
    func viewDidLoad()
    func addFriend(userId: Int)
    func unsubFriend(userId: Int)
    func subscriber(at indexPath: IndexPath) -> Subscriber
    func friend(at indexPath: IndexPath) -> Subscriber
    func getSubscribers() -> [Subscriber]
    func getFriends() -> [Subscriber]
    func didSelectSubscriber(at indexPath: IndexPath)
    func set(cell: SubscriberCell, with concert: Subscriber)
}

class SubscribersListPresenterImplementation: SubscribersListPresenter {
    var successSubscribe: (() -> Void)?
    var followSelected: ((Int) -> Void)?

    private let service: SubscribersService
    private let concertId: Int
    private var cell: SubscriberCell?
    weak var view: SubscribersListView?

    var isNeedToSubscribe = false

    var subscribersCount = 0
    var friendsCount = 0

    private var subscribers: [Subscriber] = [] {
        didSet {
            subscribersCount = subscribers.count
        }
    }

    private var friends: [Subscriber] = [] {
        didSet {
            friendsCount = friends.count
        }
    }

    init(service: SubscribersService, id: Int) {
        self.service = service
        self.concertId = id
    }

    func viewDidLoad() {
        for friend in subscribers {
            if friend.isFriend == true && !friends.contains(friend) {
                friends.append(friend)
            }
        }
        loadSubscribers()
    }

    func loadSubscribers() {
        if isNeedToSubscribe {
            service.loadSubscribers(id: concertId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let subscribers):
                    self.subscribers = subscribers
                    self.successSubscribe?()
                    self.view?.reloadData()

                case .failure(let error):
                    self.view?.alert(message: error.rawValue)
                }
            }
        } else {
            service.updateSubscribers(id: concertId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let subscribers):
                    self.subscribers = subscribers
                    self.view?.reloadData()

                case .failure(let error):
                    self.view?.alert(message: error.rawValue)
                }
            }
        }
    }

    func addFriend(userId: Int) {
        service.addFriend(id: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.cell?.updateFollowButton()
                self.subscribers.enumerated().forEach {
                    let id = $0.element.id
                    if id == userId {
                        self.subscribers[$0.offset].isFriend = true
                        if !self.friends.contains(self.subscribers[$0.offset]) {
                            self.friends.append(self.subscribers[$0.offset])
                        }
                    }
                }
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
                self.subscribers.enumerated().forEach {
                    let id = $0.element.id
                    var sub = self.subscribers[$0.offset]
                    if  id == userId {
                        sub.isFriend = false
                        if self.friends.contains(where: { $0.id == sub.id }), let index = self.friends.firstIndex(where: { $0.id == id }) {
                            self.subscribers[$0.offset].isFriend = false
                            self.friends.remove(at: index)
                        }
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

    func subscriber(at indexPath: IndexPath) -> Subscriber {
        subscribers[indexPath.item]
    }

    func friend(at indexPath: IndexPath) -> Subscriber {
        friends[indexPath.item]
    }

    func getSubscribers() -> [Subscriber] {
        subscribers
    }

    func getFriends() -> [Subscriber] {
        for friend in subscribers {
            if friend.isFriend == true && !friends.contains(friend) {
                friends.append(friend)
            }
        }
        return friends
    }

    func didSelectSubscriber(at indexPath: IndexPath) {
        service.loadUser(id: subscribers[indexPath.item].id) { [self] result in
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

    func set(cell: SubscriberCell, with subscriber: Subscriber) {
        self.cell = cell
        let cellPresenter = SubscriberCellPresenterImplementation()
        cellPresenter.subscriber = subscriber
        if cell.subscriber?.isFriend == false {
            cell.closure = addFriend(userId:)
        } else {
            cell.closure = unsubFriend(userId:)
        }
        cellPresenter.view = cell
        cell.presenter = cellPresenter
    }
}
