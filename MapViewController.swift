//
//  MapViewController.swift
//  Covid-19_Project
//
//  Created by admin on 02/05/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager() // will handle location (GPS, Wifi) updates
    
    override func viewDidLoad() {
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization() // Ask user to apprive locatioon sharing with the app
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // how precise we want it
        locationManager.startUpdatingLocation() // start getting data from device
        
        Repository.startListener(vc: self)
        
        Repository.add(username: Authentication.getUsername(), location: locationManager.location!.coordinate)
        
        super.viewDidLoad()
    }
    
    @IBAction func signoutBtnPressed(_ sender: UIButton) {
        Authentication.signOut()
    }
    
    func updateMarkers(snap: QuerySnapshot) { // raw data is passed in from Firebase
        let markers = Repository.getMKAnnotationsFromData(snap: snap)
        print("I am markers", markers)
        print("updating markers...")
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }
    
}
