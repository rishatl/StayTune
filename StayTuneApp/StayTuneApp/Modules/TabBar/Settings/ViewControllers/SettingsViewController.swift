//
//  SettingsViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 23.04.2021.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController {

    var toAuthorization: (() -> Void)?
    var toEditProfile: (() -> Void)?
    var toAboutApp: (() -> Void)?

    // MARK: - Properties

    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        userInfoHeader.viewDidLoad()
    }

    // MARK: - Helper Functions

    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60

        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)

        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }

    func configureUI() {
        configureTableView()
        navigationItem.title = "Settings"
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let section = SettingsSection(rawValue: section) else { return 0 }

        switch section {
        case .Social:
            return SocialOptions.allCases.count

        case .Communications:
            return CommunicationsOptions.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        cell.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        cell.textLabel?.textColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            cell.sectionType = social

        case .Communications:
            let communications = CommunicationsOptions(rawValue: indexPath.row)
            cell.sectionType = communications
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }

        if section == .Social {
            switch SocialOptions(rawValue: indexPath.row) {
            case .editProfile:
                toEditProfile?()

            case .logOut:
                toAuthorization?()

            case .none:
                break
            }
        }

        if section == .Communications {
            switch CommunicationsOptions(rawValue: indexPath.row) {
            case .notifications:
                break

            case .aboutApp:
                toAboutApp?()

            default:
                break
            }
        }
    }
}
