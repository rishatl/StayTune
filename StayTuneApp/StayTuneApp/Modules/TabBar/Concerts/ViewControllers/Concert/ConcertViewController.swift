//
//  CouncilMemberViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit

class ConcertViewController: UIViewController, ConcertView, UITableViewDataSource, UITableViewDelegate {

    // Data model: These strings will be the data for the table view cells
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    // number of rows in table view
    
    var presenter: ConcertPresenterImplementation?
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var aboutLabel: UILabel!
    @IBOutlet private var singerLabel: UILabel!
    @IBOutlet private var singerUrlLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    @IBOutlet private var mapsButton: UIButton!

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        setUpElements()
    }

    func setUpElements() {
        FilledButtonUtilities.styleFilledButton(mapsButton)
    }

    func set(name: String) {
        nameLabel.text = name
    }

    func set(date: Date) {
        dateLabel.text = DateFormatter.getStringFromDate(date)
    }

    func set(location: String) {
        locationLabel.text = location
    }

    func set(about: String) {
        aboutLabel.text = about
    }

    func set(singer: String) {
        singerLabel.text = singer
    }

    func set(singerURL singerUrl: URL?) {
        singerUrlLabel.text = singerUrl?.absoluteString
    }

    func set(price: Int) {
        priceLabel.text = String(price) + "Rub"
    }

    func set(imageURL: URL?) {
        imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "No-Image-Placeholder"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!

        cell.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        cell.textLabel?.textColor = UIColor(red: 255.0 / 255.0, green: 195.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)

        // set the text from the data model
        cell.textLabel?.text = self.animals[indexPath.row]

        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    @IBAction func mapsTapped(_ sender: Any) {
        presenter?.toMaps?((presenter?.getLocation())!, (presenter?.getLatitude())!, (presenter?.getLongitude())!)
    }

    @IBAction private func subscribe(_ sender: Any) {
        tableView.isHidden = false
    }
}
