//
//  RestaurantViewModel.swift
//  Yelp-MVVM-Example
//
//  Created by timofey makhlay on 11/30/20.
//

import UIKit

class RestaurantCellViewModel {
    let name: String
    let previewImage: String
    let descriptionText: String
    
    init(name: String, imageURL: String, cost: String, reviews: Int) {
        self.name = name
        self.previewImage = imageURL
        self.descriptionText = "\(cost), \(reviews) Reviews"
    }
}
