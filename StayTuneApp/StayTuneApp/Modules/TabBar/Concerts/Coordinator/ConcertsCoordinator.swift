//
//  ConcertsCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 24.03.2021.
//

import Foundation
import UIKit

class ConcertsCoordinator {
    var navigationController = UINavigationController()
    private let storyboard = UIStoryboard(name: "Concerts", bundle: nil)

    func concertsController() -> UIViewController {
        let concertListVC: ConcertListViewController = storyboard.instantiateViewController(identifier: "ConcertListViewController")
        concertListVC.tabBarItem = UITabBarItem(title: "Concerts", image: UIImage(named: "calendar"), tag: 0)
        let presenter = ConcertListPresenterImplementation(service: RestConcertService())
        presenter.view = concertListVC
        presenter.onMemberSelected = { [self] member in
            self.showConcertMemberDetails(member: member)
        }
        concertListVC.presenter = presenter
        navigationController.viewControllers = [concertListVC]
        return navigationController
    }

    func showConcertMemberDetails(member: ConcertMemberDetails) {
        let concertMemberVC: ConcertMemberViewController = storyboard.instantiateViewController(identifier: "ConcertMemberViewController")
        let presenter = ConcertMemberPresenterImplementation()
        presenter.view = concertMemberVC
        presenter.memberDetails = member
        concertMemberVC.presenter = presenter
        navigationController.pushViewController(concertMemberVC, animated: true)
    }
}
