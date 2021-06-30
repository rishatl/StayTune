//
//  ConcertsCoordinator.swift
//  StayTuneApp
//
//  Created by Rishat on 24.03.2021.
//

import Foundation
import UIKit

class ConcertsCoordinator {
    var mainCoordinator: MainCoordinator?
    var navigationController = UINavigationController()
    private let storyboard = UIStoryboard(name: "Concerts", bundle: nil)

    func concertsController() -> UIViewController {
        let concertListVC: ConcertListViewController = storyboard.instantiateViewController(withIdentifier: "ConcertListViewController") as! ConcertListViewController
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
        let concertVC: ConcertViewController = storyboard.instantiateViewController(withIdentifier: "ConcertViewController") as! ConcertViewController
        let presenter = ConcertPresenterImplementation(service: RestSubscribersService())
        presenter.view = concertVC
        presenter.concertDetails = concert
        presenter.toMaps = { [self] location, latitude, longitude in
            self.navigationController.pushViewController(self.mapController(location: location, latitude: latitude, longitude: longitude), animated: true)
        }
        presenter.toSubscribers = { [self] concertId, flag in
            self.navigationController.pushViewController(self.subscribersController(concertId: concertId, flag: flag), animated: true)
        }
        concertVC.presenter = presenter
        navigationController.pushViewController(concertVC, animated: true)
    }

    func mapController(location: String, latitude: Double, longitude: Double) -> UIViewController {
        let viewController = MapViewController()
        viewController.configure(location: location, latitude: latitude, longitude: longitude)
        return viewController
    }

    func subscribersController(concertId: Int, flag: Bool) -> UIViewController {
        let subscribersListVC = SubscribersViewController()
        let presenter = SubscribersListPresenterImplementation(service: RestSubscribersService(), id: concertId)
        presenter.isNeedToSubscribe = flag
        presenter.successSubscribe = { [weak self, flag] in
            if flag {
                guard let controllers = self?.navigationController.viewControllers,
                      controllers.count > 2,
                      let controller = controllers[controllers.count - 2] as? ConcertViewController else { return }
                controller.changeSubscribe()
            }
        }
        presenter.view = subscribersListVC
        subscribersListVC.presenter = presenter
        return subscribersListVC
    }

    func openConcertDetails(concert: ConcertDetails) {
        mainCoordinator?.openConcertDetails(concert: concert)
    }
}
