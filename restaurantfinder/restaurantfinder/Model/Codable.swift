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

    private enum RestaurantCodingKeys: String, CodingKey {
        case name
        case cuisines
        case location
        case userRating = "user_rating"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RestaurantCodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        cuisines = try values.decode(String.self, forKey: .cuisines)
        location = try values.decode(Address.self, forKey: .location)
        userRating = try values.decode(UserRating.self, forKey: .userRating)
    
    }
}

struct Address: Decodable {
    let address: String?
    let latitude: String?
    let longitude: String?
}

struct UserRating: Decodable {
    let rating: String?
    let votes: String?
    
    private enum UserCodingKeys: String, CodingKey {
        case rating = "aggregate_rating"
        case votes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)
        rating = try values.decode(String.self, forKey: .rating)
        votes = try values.decode(String.self, forKey: .votes)
    }
}
