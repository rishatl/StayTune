//
//  CouncilMemberPresenterImplementation.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit
import Kingfisher

protocol ConcertMemberView: AnyObject {
    func set(name: String)
    func set(bio: String)
    func set(rank: String)
    func set(imageURL: URL?)
}

protocol ConcertMemberPresenter {
    func viewDidLoad()
}

class ConcertMemberPresenterImplementation: ConcertMemberPresenter {
    var memberDetails: ConcertMemberDetails?
    weak var view: ConcertMemberView?

    func viewDidLoad() {
        guard let memberDetails = memberDetails,
              let view = view
        else { return }
        view.set(name: memberDetails.councilMember.name)
        view.set(bio: memberDetails.bio)
//        view.set(rank: name(of: memberDetails.councilMember.rank))
//        view.set(imageURL: memberDetails.councilMember.imageUrl)
    }

//    private func name(of rank: ConcertMember.Rank) -> String {
//        switch rank {
//        case .grandmaster:
//            return "Jedi Grandmaster"
//        case .headOfCouncil:
//            return "Jedi Master, Head of Jedi Counci"
//        case .master:
//            return "Jedi Master"
//        case .knight:
//            return "Take a seat"
//        }
//    }
}
