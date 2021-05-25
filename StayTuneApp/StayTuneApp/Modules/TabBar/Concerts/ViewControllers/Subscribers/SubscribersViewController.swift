//
//  SubscribersViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 12.05.2021.
//

import UIKit

class SubscribersViewController: UIViewController, SubscribersListView {
    func reloadData() {
        rowsToDisplay = presenter?.getSubscribers()
        friendsToDisplay = presenter?.getFriends()
        tableView.reloadData()
    }

    var presenter: SubscribersListPresenter?

    private let cellId: String = "SubscriberCell"
    let tableView = UITableView(frame: .zero, style: .plain)

    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["All Subscribers", "Your Friends"])
        if #available(iOS 13.0, *) {
            sc.selectedSegmentTintColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        }
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()

    @objc fileprivate func handleSegmentChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            rowsToDisplay = presenter?.getSubscribers()

        case 1:
            friendsToDisplay = presenter?.getFriends()

        default:
            break
        }
        reloadData()
    }

    lazy var rowsToDisplay = presenter?.getSubscribers()
    lazy var friendsToDisplay = presenter?.getFriends()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Subscribers"

        tableView.register(UINib(nibName: "SubscriberCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)

        tableView.dataSource = self
        tableView.delegate = self
        setUpTableView()
        presenter?.viewDidLoad()
    }

    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        return control
    }()

    @objc func updateData() {
        presenter?.loadSubscribers()
        reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    func setUpTableView() {
        view.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
        tableView.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)

        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 6, right: 12)
        paddedStackView.isLayoutMarginsRelativeArrangement = true

        let stackView = UIStackView(arrangedSubviews: [
            paddedStackView, tableView
        ])
        stackView.axis = .vertical

        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero)
    }
}

extension SubscribersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return presenter?.subscribersCount ?? 0
        }
        return presenter?.friendsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SubscriberCell else {
            fatalError("Could not dequeue cell")
        }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        cell.textLabel?.textColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        if segmentedControl.selectedSegmentIndex == 0 {
            cell.subscriber = self.rowsToDisplay?[indexPath.row]

            guard let subscriber = presenter?.subscriber(at: indexPath) else { fatalError("Could not dequeue cell") }
            cell.followButton.tag = subscriber.id
            presenter?.set(cell: cell, with: subscriber)
        } else {
            cell.friend = self.friendsToDisplay?[indexPath.row]

            guard let friend = presenter?.friend(at: indexPath) else { fatalError("Could not dequeue cell") }
            cell.followButton.tag = friend.id
            presenter?.set(cell: cell, with: friend)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        57
    }
}

extension SubscribersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectSubscriber(at: indexPath)
    }
}
