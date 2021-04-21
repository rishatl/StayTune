//
//  SettingsViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 15.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    var toAuthorization: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }



    @IBAction func logOutTapped(_ sender: Any) {
        toAuthorization?()
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 2
//
//        case 1:
//            return 2
//
//        default:
//            return 0
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as SettingsSell
//        switch indexPath.section {
//        case 0:
//            return 2
//
//        case 1:
//            return 2
//        }
//
//        default:
//            break
//    }
}
