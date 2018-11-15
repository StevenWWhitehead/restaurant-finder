//
//  DetailVC.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/13/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import UIKit
import Cosmos
import CoreLocation
import MapKit

class DetailVC: UIViewController {

    @IBOutlet weak var cuisinesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var costForTwoLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurantDetails: Restaurant!
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = restaurantDetails.name ?? ""
        cuisinesLabel.text = restaurantDetails.cuisines ?? ""
        addressLabel.text = restaurantDetails.location?.address ?? ""
        cosmosView.text = "(\(restaurantDetails.userRating?.votes ?? "0") reviews)"
        
        if let rating = restaurantDetails.userRating?.aggregate_rating {
            cosmosView.rating = (rating as NSString).doubleValue
        } else {
            cosmosView.rating = 0.0
        }
        
        if let lat = restaurantDetails.location?.latitude, let lon = restaurantDetails.location?.longitude {
            setMap(lat: lat, lon: lon)
        } else {
            mapView.isHidden = true
        }
    }
    
    func setMap(lat: String, lon: String) {
        
        let newLat = (lat as NSString).doubleValue
        let newLon = (lon as NSString).doubleValue
        let location = CLLocation(latitude: newLat, longitude: newLon)
        let regionRadius: CLLocationDistance = 800
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
