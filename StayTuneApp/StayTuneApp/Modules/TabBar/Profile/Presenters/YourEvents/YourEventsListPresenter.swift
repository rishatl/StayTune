//
//  YourEventsListPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 23.05.2021.
//

import Foundation
import UIKit
import KeychainAccess

protocol YourEventsListView: UIViewController {
    func reloadData()
}

protocol YourEventsListPresenter {
    var onConcertSelected: ((ConcertDetails) -> Void)? { get set }
    var concertsCount: Int { get }
    func loadConcerts(id: Int)
    func getId() -> Int?
    func concert(at indexPath: IndexPath) -> Concert
    func getConcerts() -> [Concert]
    func viewDidLoad()
    func didSelectConcert(at indexPath: IndexPath)
    func set(cell: YourEventsCell, with concert: Concert)
}

class YourEventsListPresenterImplementation: YourEventsListPresenter {
    var onConcertSelected: ((ConcertDetails) -> Void)?
    private let service: YourEventsService

    weak var view: YourEventsListView?

    var concertsCount = 0

    let keychain = Keychain(service: "user_token")

    private var concerts: [Concert] = [] {
        didSet {
            concertsCount = concerts.count
        }
    }

    init(service: YourEventsService) {
        self.service = service
    }

    func viewDidLoad() {
        guard let userId = getId() else {
            return
        }
        loadConcerts(id: userId)
    }

    func getId() -> Int? {
        guard let id = Int(keychain["id"]!) else { return nil }
        return id
    }

    func loadConcerts(id: Int) {
        service.loadConcerts(id: id) { [self] result in
            switch result {
            case .success(let concerts):
                self.concerts = concerts
                view?.reloadData()

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func concert(at indexPath: IndexPath) -> Concert {
        concerts[indexPath.item]
    }

    func getConcerts() -> [Concert] {
        concerts
    }

    func didSelectConcert(at indexPath: IndexPath) {
        service.loadConcertDetails(id: concerts[indexPath.item].id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let concertDetails):
                self.onConcertSelected?(concertDetails)

            case .failure(let error):
                self.view?.alert(message: error.rawValue)
            }
        }
    }

    func set(cell: YourEventsCell, with concert: Concert) {
        let cellPresenter = YourEventsCellPresenterImplementation()
        cellPresenter.concert = concert
        cellPresenter.view = cell
        cell.presenter = cellPresenter
    }
}
