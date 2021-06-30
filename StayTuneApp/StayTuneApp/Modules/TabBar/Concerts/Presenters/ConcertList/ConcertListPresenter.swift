//
//  CouncilListPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation
import UIKit

protocol ConcertListView: UIViewController {
    func reloadData()
}

protocol ConcertListPresenter {
    var onConcertSelected: ((ConcertDetails) -> Void)? { get set }
    var concertsCount: Int { get }
    func loadConcerts()
    func concert(at indexPath: IndexPath) -> Concert
    func getConcerts() -> [Concert]
    func viewDidLoad()
    func didSelectConcert(at indexPath: IndexPath)
    func set(cell: ConcertCell, with concert: Concert)
}

class ConcertListPresenterImplementation: ConcertListPresenter {
    var onConcertSelected: ((ConcertDetails) -> Void)?
    private let service: ConcertService

    weak var view: ConcertListView?

    var concertsCount = 0

    private var concerts: [Concert] = [] {
        didSet {
            concertsCount = concerts.count
        }
    }

    init(service: ConcertService) {
        self.service = service
    }

    func viewDidLoad() {
        loadConcerts()
    }

    func loadConcerts() {
        service.loadConcerts { [self] result in
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

    func set(cell: ConcertCell, with concert: Concert) {
        let cellPresenter = ConcertCellPresenterImplementation()
        cellPresenter.concert = concert
        cellPresenter.view = cell
        cell.presenter = cellPresenter
    }
}
