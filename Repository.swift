//
//  Repository.swift
//  Covid-19_Project
//
//  Created by Thomas Vindelev on 03/05/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class Repository {
    
    private static let db = Firestore.firestore()
    
    private static let path = "TestingUsers"
    
    static func startListener(vc: MapViewController) {
        print("listener started")
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil { // check for error, and return if true
                return
            }
            if let snap = snap { // this is a way of unwrapping the snap optional
                vc.updateMarkers(snap: snap)
            }
        }
    }
    
    static func removeUserLocation(username: String) {
        db.collection(path).document(username).delete()
    }
    
    static func add(username: String, location: CLLocationCoordinate2D) {
        let ref = db.collection(path).document(username)
        var map = [String:Any]()
        map["username"] = username
        map["location"] = GeoPoint(latitude: location.latitude, longitude: location.longitude)
        ref.setData(map)
    }
    
    // Getting all coordinates on the fly
    static func getMKAnnotationsFromData(snap:QuerySnapshot) -> [MKPointAnnotation] {
        var markers = [MKPointAnnotation]() // create an empty list
        for doc in snap.documents {
            print("recieved data", doc.data())
            let map = doc.data() // the data delivered is stored in a map with key and value
            let username = map["username"] as! String
            let geoPoint = map["location"] as! GeoPoint
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = username
            let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
        }
        return markers
    }
        
}
