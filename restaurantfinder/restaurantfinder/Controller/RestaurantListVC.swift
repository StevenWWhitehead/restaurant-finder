//
//  RestaurantListVC.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/13/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class RestaurantListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var searchArea: CLPlacemark!
    let zomatoApi = ZomatoApi()
    
    var restaurants = [Restaurants]()
    
    var restaurantToDetail: Restaurant!

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProgressHUD()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        guard let lat = searchArea.location?.coordinate.latitude, let lon = searchArea.location?.coordinate.longitude else { return }
        
        zomatoApi.getRestaurantList(lat: lat, lon: lon) { (root) in
            self.hideProgressHUD()
            if let root = root {
                self.navigationItem.title = root.location?.title
                self.restaurants = root.restaurants ?? []
                self.listTableView.reloadData()
            } else {
                let notification = UIAlertController(title: "Error", message: "Cannot complete search at this time. Please try again.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                notification.addAction(action)
                
                self.present(notification, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListCell {
            guard let restaurant = restaurants[indexPath.row].restaurant else { return UITableViewCell() }
            cell.configureCell(restaurant: restaurant, location: searchArea.location!)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let choosenRestaurant = restaurants[indexPath.row].restaurant else { return }
        restaurantToDetail = choosenRestaurant
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailVC {
            detailVC.restaurantDetails = restaurantToDetail
        }
    }
    
    func showProgressHUD() {
        SVProgressHUD.show(withStatus: "Finding Restaurants")
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideProgressHUD() {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
