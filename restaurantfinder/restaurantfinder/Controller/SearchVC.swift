//
//  SearchVC.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/13/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import UIKit
import CoreLocation

class SearchVC: UIViewController, UITextFieldDelegate {
    
    var searchArea: CLPlacemark!

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func searchBtnTapped(_ sender: Any) {
        
        createSearch()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .search {
            if searchButton.isEnabled {
                createSearch()
                return true
            }
        }
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let restaurantVC = segue.destination as? RestaurantListVC {
            restaurantVC.searchArea = searchArea
        }
    }
    
    func createSearch() {
        guard let address = searchTextField.text else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                debugPrint(error.debugDescription)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("Location not found")
                return
            }
            
            self.searchArea = placemark
            self.searchTextField.text = ""
            self.searchButton.isEnabled = false
            self.performSegue(withIdentifier: "toRestaurantListVC", sender: self)
        }
    }
    
}

