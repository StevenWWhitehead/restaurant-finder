//
//  ZomatoAPI.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/13/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import Foundation
import Alamofire

class ZomatoApi {
    
    func getRestaurantList(lat: Double, lon: Double, completion: @escaping LocationResponseCompletion) {
        
        guard let url = URL(string: "\(URL_GEOCODE_BASE)\(URL_LAT)\(lat)\(URL_LON)\(lon)") else { return }
        
        let headers: HTTPHeaders = [
            "user_key": "365eed23911d387b0195a344e5e79fa3",
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                debugPrint("The error is " + error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else { return completion(nil) }
            
            let jsonDecoder = JSONDecoder()
            do {
                let root = try jsonDecoder.decode(Root.self, from: data)
                completion(root)
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }

    
}
