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
        presenter.onConcertSelected = { [self] concert in
            self.showConcertDetails(concert: concert)
        }
        concertListVC.presenter = presenter
        navigationController.viewControllers = [concertListVC]
        return navigationController
    }

    func showConcertDetails(concert: ConcertDetails) {
        let concertVC: ConcertViewController = storyboard.instantiateViewController(identifier: "ConcertViewController")
        let presenter = ConcertPresenterImplementation()
        presenter.view = concertVC
        presenter.concertDetails = concert
        presenter.toMaps = { [self] location, latitude, longitude in
            self.navigationController.pushViewController(self.mapController(location: location, latitude: latitude, longitude: longitude), animated: true)
        }
        concertVC.presenter = presenter
        navigationController.pushViewController(concertVC, animated: true)
    }

    func mapController(location: String, latitude: Double, longitude: Double) -> UIViewController {
        let viewController: MapViewController = MapViewController()
        viewController.configure(location: location, latitude: latitude, longitude: longitude)
        return viewController
    }
}
