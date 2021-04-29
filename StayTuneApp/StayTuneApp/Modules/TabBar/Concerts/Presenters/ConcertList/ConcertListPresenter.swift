//
//  CouncilListPresenter.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation

protocol ConcertListView: AnyObject {
    func reloadData()
}

protocol ConcertListPresenter {
    var onMemberSelected: ((ConcertMemberDetails) -> Void)? { get set }
    var memberCount: Int { get }
    func member(at indexPath: IndexPath) -> ConcertMember
    func viewDidLoad()
    func didSelectMember(at indexPath: IndexPath)
    func set(cell: ConcertMemberCell, with member: ConcertMember)
}

class ConcertListPresenterImplementation: ConcertListPresenter {
    var onMemberSelected: ((ConcertMemberDetails) -> Void)?
    private let service: ConcertService

    weak var view: ConcertListView?
    var memberCount = 0

    private var members: [ConcertMember] = [] {
        didSet {
            memberCount = members.count
        }
    }

    init(service: ConcertService) {
        self.service = service
    }

    func viewDidLoad() {
        loadMembers()
    }

    func loadMembers() {
        service.loadMembers { [self] result in
            switch result {
                case .success(let members):
                    self.members = members
                    view?.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

    func member(at indexPath: IndexPath) -> ConcertMember {
        members[indexPath.item]
    }

    func didSelectMember(at indexPath: IndexPath) {
        service.loadMemberDetails(id: members[indexPath.item].id) { [self] result in
            switch result {
                case .success(let memberDetails):
                    onMemberSelected?(memberDetails)
                case .failure(let error):
                    print(error)
            }
        }
    }

    func set(cell: ConcertMemberCell, with member: ConcertMember) {
        let cellPresenter = ConcertMemberCellPresenterImplementation()
        cellPresenter.member = member
        cellPresenter.view = cell
        cell.presenter = cellPresenter
    }
}
