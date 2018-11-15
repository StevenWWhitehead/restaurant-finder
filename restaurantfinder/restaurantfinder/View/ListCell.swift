//
//  ListCell.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/13/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import UIKit
import CoreLocation

class ListCell: UITableViewCell {
    
    let amountString = "$$$$$$"
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var cuisineLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!

    func configureCell(restaurant: Restaurant, location: CLLocation) {
        restaurantNameLabel.text = restaurant.name
        cuisineLabel.text = restaurant.cuisines
        //amountLabel.text = convertIntToDollars(amount: restaurant.dollarAMount)
        let distance = calculateDistanceWith(coordinates: location, lat: restaurant.location!.latitude!, lon: restaurant.location!.longitude!)
        distanceLabel.text = "\(distance.roundTwoDecimal()) miles"
    }
    
    func convertIntToDollars(amount:Int) -> String {
        let index = amountString.index(amountString.startIndex, offsetBy: amount)
        return String(amountString[..<index])
    }
    
    func calculateDistanceWith(coordinates: CLLocation, lat: String, lon: String) -> Double {
        
        let newLat = (lat as NSString).doubleValue
        let newLon = (lon as NSString).doubleValue
        let location = CLLocation(latitude: newLat, longitude: newLon)
        let distanceInMeters = coordinates.distance(from: location)
        
        return distanceInMeters/1609.344
    }
}

extension Double {
    func roundTwoDecimal() -> Double {
        let divisor = pow(10.0, 2.0)
        return (self * divisor).rounded() / divisor
    }
}
