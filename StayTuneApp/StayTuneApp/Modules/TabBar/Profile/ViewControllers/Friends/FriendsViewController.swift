//
//  FriendsViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 07.05.2021.
//

import UIKit

class FriendsViewController: UIViewController, FriendsListView {
    func reloadData() {
        friendsToDisplay = presenter?.getFriends()
        tableView.reloadData()
    }

    var presenter: FriendsListPresenter?

    private let cellId: String = "FriendCell"
    let tableView = UITableView(frame: .zero, style: .plain)

    lazy var friendsToDisplay = presenter?.getFriends()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: cellId)
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
        presenter?.loadFriends()
        reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    func setUpTableView() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
        tableView.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.friendsCount else {
            fatalError()
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? FriendCell else {
            fatalError("Could not dequeue cell")
        }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        cell.textLabel?.textColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        cell.friend = self.friendsToDisplay?[indexPath.row]

        guard let friend = presenter?.friend(at: indexPath) else { fatalError("Could not dequeue cell") }
        cell.followButton.tag = friend.id
        presenter?.set(cell: cell, with: friend)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        57
    }
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectSubscriber(at: indexPath)
    }
}
