//
//  MapViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 04.05.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    private var location: String = ""
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Maps"
        view.backgroundColor = UIColor(red: 37.0 / 255.0, green: 37.0 / 255.0, blue: 37.0 / 255.0, alpha: 1)

        GMSServices.provideAPIKey("AIzaSyBFQ1NbM6WaITIlggdSoeCwFfBNWL3TKAc")

        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = location
        marker.map = mapView
    }

    func configure(location: String,
                   latitude: Double,
                   longitude: Double) {
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
}
