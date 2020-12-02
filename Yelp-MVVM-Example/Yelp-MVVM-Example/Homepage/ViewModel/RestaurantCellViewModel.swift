//
//  RestaurantViewModel.swift
//  Yelp-MVVM-Example
//
//  Created by timofey makhlay on 11/30/20.
//

import UIKit

class RestaurantCellViewModel {
    let name: String
    let previewImage: UIImage
    let descriptionText: String
    
    init(name: String, image: UIImage, cost: String, reviews: Int) {
        self.name = name
        self.previewImage = image
        self.descriptionText = "\(cost), \(reviews) Reviews"
    }
}
