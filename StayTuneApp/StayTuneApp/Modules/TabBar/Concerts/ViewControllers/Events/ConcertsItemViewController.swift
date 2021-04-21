//
//  EventItemViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 09.04.2021.
//

import UIKit

/**
    EventItem View Controller, contains detailed view of a selected Event.
*/
class ConcertsItemViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    //Reference to selected event to pass to details view
    var selectedEventItem: Event!

    @IBOutlet private weak var eventTitleLabel: UITextField! { didSet { eventTitleLabel.delegate = self } }
    @IBOutlet private weak var eventVenueLabel: UITextField! { didSet { eventVenueLabel.delegate = self } }
    @IBOutlet private weak var eventCityLabel: UITextField! { didSet { eventCityLabel.delegate = self } }
    @IBOutlet private weak var eventCountryLabel: UITextField! { didSet { eventCountryLabel.delegate = self } }
    @IBOutlet private weak var eventFBURLLabel: UITextField! { didSet { eventFBURLLabel.delegate = self } }
    @IBOutlet private weak var eventTicketURL: UITextField! { didSet { eventTicketURL.delegate = self } }
    @IBOutlet private weak var eventDatePicker: UIDatePicker!
    @IBOutlet private weak var scrollViewContainer: UIScrollView!
    @IBOutlet private weak var segmentController: UISegmentedControl!
    @IBOutlet private weak var attendeesTableView: UITableView!

    private let idNamespace = EventAttributes.eventId.rawValue
    private let titleNamespace  = EventAttributes.title.rawValue
    private let dateNamespace  = EventAttributes.date.rawValue
    private let venueNamespace  = EventAttributes.venue.rawValue
    private let cityNamespace  = EventAttributes.city.rawValue
    private let countryNamespace = EventAttributes.country.rawValue
    private let fbURLNamespace = EventAttributes.fb_url.rawValue
    private let ticketURLNamespace  = EventAttributes.ticket_url.rawValue
    private let attendeesNamespace  = EventAttributes.attendees.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.setup()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setup() {

        attendeesTableView.delegate = self
        attendeesTableView.dataSource = self

        if(self.selectedEventItem != nil) {
        }
    }

    /**
        Call endpoint save event handler, pass this event together with
        populated dictionary from field values.
    */
    @IBAction private func eventSaveButtonTapped(_ sender: UIBarButtonItem) {
    }

    /**
        Set all fields text to a predefined default value.
    */
    @IBAction private func clearButtonTapped(_ sender: AnyObject) {
        let defaultValue = "Live long and prosper 🖖🏾" // need to change to empty String ;p
        eventTitleLabel.text = defaultValue
        eventVenueLabel.text = defaultValue
        eventCityLabel.text = defaultValue
        eventCountryLabel.text = defaultValue
        eventFBURLLabel.text = defaultValue
        eventTicketURL.text = defaultValue
        eventDatePicker.date = Date()
    }

    /**
        Delete event item from datastore.
    */
    @IBAction private func deleteEventButtonTapped(_ sender: UIButton) {
        if(selectedEventItem != nil) {
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: Textfield delegates

    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollViewContainer.setContentOffset(CGPoint.zero, animated: true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollViewContainer.setContentOffset(CGPoint(x: scrollViewContainer.frame.origin.x, y: textField.frame.origin.y - 8), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    // MARK Utility methods

    /**
        Set field values for passed on event item.
    */

    private func setUpElements() {
        TextFieldUtilities.styleTextField(eventTitleLabel)
        TextFieldUtilities.styleTextField(eventVenueLabel)
        TextFieldUtilities.styleTextField(eventCityLabel)
        TextFieldUtilities.styleTextField(eventCountryLabel)
        TextFieldUtilities.styleTextField(eventFBURLLabel)
        TextFieldUtilities.styleTextField(eventTicketURL)
    }

    private func setFieldValues() {
        eventTitleLabel.text = selectedEventItem.title
        eventVenueLabel.text = selectedEventItem.venue
        eventCityLabel.text = selectedEventItem.city
        eventCountryLabel.text = selectedEventItem.country
        eventFBURLLabel.text = selectedEventItem.fb_url as? String
        eventTicketURL.text = selectedEventItem.ticket_url as? String
        eventDatePicker.date = selectedEventItem.date as Date
    }

    /**
        Populates all fields in to dictionary
    */
    private func getFieldValues() -> Dictionary<String, NSObject> {

        var fieldDetails = [String: NSObject]()
        fieldDetails[titleNamespace] = eventTitleLabel.text as NSObject?
        fieldDetails[dateNamespace] = Date() as NSObject?
        fieldDetails[venueNamespace] = eventVenueLabel.text as NSObject?
        fieldDetails[cityNamespace] = eventCityLabel.text as NSObject?
        fieldDetails[countryNamespace] = eventCountryLabel.text as NSObject?
        fieldDetails[fbURLNamespace] = eventFBURLLabel.text as NSObject?
        fieldDetails[ticketURLNamespace] = eventTicketURL.text as NSObject?
        fieldDetails[dateNamespace] = eventDatePicker.date as NSObject?

        return fieldDetails
    }

    @IBAction private func switchSegmentTapped(_ sender: AnyObject) {

        if segmentController.selectedSegmentIndex == 0 {
            attendeesTableView.isHidden = true
            scrollViewContainer.isHidden = false

            if selectedEventItem != nil {
                self.title = "Edit event"
            } else {
                self.title = "Add event"
            }
        }

        if segmentController.selectedSegmentIndex == 1 {
            scrollViewContainer.isHidden = true
            attendeesTableView.isHidden = false

            if selectedEventItem != nil {
                self.title = String(format: "Attendees (%i)", selectedEventItem.attendees.count)
            } else {
                self.title = "Attendees (0)"
            }
        }
    }

    // MARK: Attendees TableView Delegates

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int

        if selectedEventItem != nil {
            count = selectedEventItem.attendees.count
        } else {
            count = 0
        }

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attendeesTableCellIdentifier = "attendeesItemCell"
        let attendeeCell = tableView.dequeueReusableCell(withIdentifier: attendeesTableCellIdentifier, for: indexPath)
        let attendees = selectedEventItem.attendees as! [String]
        attendeeCell.textLabel!.text = attendees[indexPath.row]

        return attendeeCell
    }
}

