//
//  EventTableViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 09.04.2021.
//

import UIKit

/**
    The EventTable ViewController that retrieves and displays events.
*/
class ConcertsViewController: UITableViewController, UISearchResultsUpdating {

    private var eventList: Array<Event> = []
    private var filteredEventList: Array<Event> = []
    private var selectedEventItem: Event!
    private var resultSearchController: UISearchController!
    private let eventTableCellIdentifier = "eventItemCell"
    private let showEventItemSegueIdentifier = "showEventItemSegue"
    private let editEventItemSegueIdentifier = "editEventItemSegue"

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initResultSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Register for notifications
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.updateEventTableData), name: .updateEventTableData, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.setStateLoading), name: .setStateLoading, object: nil)

        self.title = String(format: "Concerts (%i)", eventList.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive {
            return self.filteredEventList.count
        }

        return eventList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell =
        tableView.dequeueReusableCell(withIdentifier: eventTableCellIdentifier, for: indexPath) as! ConcertsTableViewCell

        let eventItem: Event!

        if resultSearchController.isActive {
            eventItem = filteredEventList[(indexPath as NSIndexPath).row]
        } else {
            eventItem = eventList[(indexPath as NSIndexPath).row]
        }

        eventCell.eventDateLabel.text = DateFormatter.getStringFromDate(eventItem.date, dateFormat: "dd-MM\nyyyy")
        eventCell.eventTitleLabel.text = eventItem.title
        eventCell.eventLocationLabel.text = "\(eventItem.venue) - \(eventItem.city) - \(eventItem.country)"
        eventCell.eventImageView.image = self.getEventImage(indexPath)

        return eventCell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destination = segue.destination as? ConcertsItemViewController

        if segue.identifier == showEventItemSegueIdentifier {
            /*
                Two options to pass selected Event to destination:

                1) Object passing, since eventList contains Event objects:
                destination!.selectedEventItem = eventList[self.tableView.indexPathForSelectedRow!.row] as Event

                2) Utilize EventAPI, find Event by Id:
                destination!.selectedEventItem = eventAPI.getById(selectedEventItem.eventId)[0]
            */

            let selectedEventItem: Event!

            if resultSearchController.isActive {
                selectedEventItem = filteredEventList[(self.tableView.indexPathForSelectedRow! as NSIndexPath).row] as Event
                resultSearchController.isActive = false
            } else {
                selectedEventItem = eventList[(self.tableView.indexPathForSelectedRow! as NSIndexPath).row] as Event
            }

            destination!.title = "Edit event"
        } else if segue.identifier == editEventItemSegueIdentifier {
            destination!.title = "Add event"
        }
    }

    // MARK: - Table edit mode

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete item from datastore
            
            self.title = String(format: "Upcoming events (%i)", eventList.count)
        }
    }

    // MARK: - Search

    /**
        Calls the filter function to filter results by searchbar input

        - Parameter searchController: passed Controller to get text from
        - Returns: Void
    */
    func updateSearchResults(for searchController: UISearchController) {
        filterEventListContent(searchController.searchBar.text!)
        refreshTableData()
    }

    /**
        Create a searchbar, bind it to tableview header

        - Returns: Void
    */
    private func initResultSearchController() {
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()

        self.tableView.tableHeaderView = resultSearchController.searchBar
    }

    /**
        Create filter predicates to filter events on title, venue, city, data

        - Parameter searchTerm: String to search.
        - Returns: Void
    */
    private func filterEventListContent(_ searchTerm: String) {
        // Clean up filtered list
        filteredEventList.removeAll(keepingCapacity: false)

        // Create a collection of predicates,
        // search items by: title OR venue OR city
        var predicates = [NSPredicate]()
        predicates.append(NSPredicate(format: "\(EventAttributes.title.rawValue) contains[c] %@", searchTerm.lowercased()))
        predicates.append(NSPredicate(format: "\(EventAttributes.venue.rawValue) contains[c] %@", searchTerm.lowercased()))
        predicates.append(NSPredicate(format: "\(EventAttributes.city.rawValue)  contains[c] %@", searchTerm.lowercased()))

        // Create compound predicate with OR predicates
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)

        // Filter results with compound predicate by closing over the inline variable
        filteredEventList = eventList.filter { compoundPredicate.evaluate(with: $0) }
    }

    @objc func updateEventTableData() {
        refreshTableData()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }

    @objc func setStateLoading() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }

    /**
        Refresh table data

        - Returns: Void
    */
    private func refreshTableData() {
        self.eventList.removeAll(keepingCapacity: false)
        self.tableView.reloadData()
        self.title = String(format: "Upcoming events (%i)", self.eventList.count)
    }

    /**
        Retrieve image from remote or cache.

        - Returns: Void
    */
    private func getEventImage(_ indexPath: IndexPath) -> UIImage {

        // Check if local image is cached, if not use GCD to download and display it.
        // Use indexPath as reference to cell to be updated.

        // For now load from image assets locally.
        return UIImage(named: "eventImageSecond.jpg")!
    }
}

extension Notification.Name {
    static let updateEventTableData = Notification.Name(rawValue: "updateEventTableData")
    static let setStateLoading = Notification.Name(rawValue: "setStateLoading")
}
