//
//  Constants.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/13/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import Foundation

let URL_GEOCODE_BASE = "https://developers.zomato.com/api/v2.1/geocode?"
let URL_LAT = "lat="
let URL_LON = "&lon="

typealias LocationResponseCompletion = (Root?) -> Void
