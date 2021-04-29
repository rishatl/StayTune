//
//  CouncilMemberCellPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import Foundation

protocol ConcertMemberCellView: AnyObject {
    func set(name: String)
    func set(rank: String)
    func set(imageURL: URL?)
}

protocol ConcertMemberCellPresenter {
    func setupCell()
}

class ConcertMemberCellPresenterImplementation: ConcertMemberCellPresenter {
    weak var view: ConcertMemberCellView?
    var member: ConcertMember?

    func setupCell() {
        guard let view = view,
              let member = member
        else { return }
        view.set(name: member.name)
//        view.set(rank: name(of: member.rank))
//        view.set(imageURL: member.imageUrl)
    }

//    private func name(of rank: ConcertMember.Rank) -> String {
//        switch rank {
//            case .grandmaster:
//                return "Jedi Grandmaster"
//            case .headOfCouncil:
//                return "Jedi Master, Head of Jedi Counci"
//            case .master:
//                return "Jedi Master"
//            case .knight:
//                return "Take a seat"
//        }
//    }
}
