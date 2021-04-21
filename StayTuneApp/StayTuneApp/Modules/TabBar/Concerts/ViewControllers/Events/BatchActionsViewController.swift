//
//  BatchActionsViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 09.04.2021.
//

import UIKit

/**
    Batch Actions View Controller, contains the replication and batch operation actions.
*/
class BatchActionsViewController: UIViewController {

    @IBOutlet weak var dfdfgd: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction private func anonimizeListButtonTapped(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func deleteAllEventsButtonTapped(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func restoreEventsButtonTapped(_ sender: AnyObject) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction private func replicateRemoteDataButtonTapped(_ sender: AnyObject) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "setStateLoading"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
