//
//  Codable.swift
//  restaurantfinder
//
//  Created by Steve Whitehead on 11/14/18.
//  Copyright © 2018 Greenhouse Labs. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let location: LocationCode?
    let restaurants: [Restaurants]?
    let popularity: Popularity?

    enum CodingKeys: String, CodingKey {
        case location
        case restaurants = "nearby_restaurants"
        case popularity
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decode(LocationCode.self, forKey: .location)
        popularity = try values.decode(Popularity.self, forKey: .popularity)
        restaurants = try values.decode([Restaurants].self, forKey: .restaurants)
    }
}

struct Popularity: Decodable {
    let nearby_res: [String]?
}
struct LocationCode: Decodable {
    let title: String?
}

struct Restaurants: Decodable {
    let restaurant: Restaurant?
}

struct Restaurant: Decodable {
    let name: String?
    let cuisines: String?
    let location: Address?
    let userRating: UserRating?

    enum CodingKeys: String, CodingKey {
        case name
        case cuisines
        case location
        case userRating = "user_rating"
    }
}

struct Address: Decodable {
    let address: String?
    let latitude: String?
    let longitude: String?
}

struct UserRating: Decodable {
    let aggregate_rating: String?
    let votes: String?
}
