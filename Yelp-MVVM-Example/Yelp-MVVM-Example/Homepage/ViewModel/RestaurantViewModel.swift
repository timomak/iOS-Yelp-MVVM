//
//  ViewModel.swift
//  Yelp-MVVM-Example
//
//  Created by timofey makhlay on 11/30/20.
//

import UIKit

class RestaurantViewModel {
    
    /// Raw data is stored here
    private var restaurants: [Restaurant]!
    
    /// Repurposed data  for Cells
    private var cellViewModels: [RestaurantCellViewModel] = [RestaurantCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    /// Return the number of cell view models
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    /// Return closure for Completion closures
    var reloadTableViewClosure: (()->())?
    
    /// Return cell at index value
    func getCellViewModel(at indexPath: IndexPath ) -> RestaurantCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    /// Create cell view model from Onboarding Raw data
    func createCellViewModel(item: Restaurant) -> RestaurantCellViewModel {
        
        return RestaurantCellViewModel(name: item.name, imageURL: item.imageURL, cost: item.cost, reviews: item.reviews)
    }
    
    func getRestaurantRequest() {
        /// Find more documentation on the API here: https://www.yelp.com/developers/documentation
        // Set API parameters
        let params: [String:String] = [
            "term": "Pasta",
            "location": "San Francisco"
        ]
        
        // Yelp URL for business search
        let urlComp = NSURLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        
        // Authorization in header
        urlRequest.setValue("Bearer C6dyWlVsqHH1QVPUIG3tyHHyRimYF2KIHBnfl5xSy_975sNxdfejdCrZVJGDoRQyfvfWC3oTCMydO2JY1YLd87dS0KETvNRJErhq_WM3hmU_qnkj6bEWeuHV7CvEX3Yx", forHTTPHeaderField: "Authorization")
        
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    print("Json: ", json)
                    
                    // MARK: Create restaurant models
                    if let restaurantsData = json["businesses"] as? [[String: Any]] {
                        var restaurantsArray: [Restaurant] = []
                        for restaurant in restaurantsData {
                            let name = restaurant["name"] as? String ?? "unknown"
                            let price = restaurant["price"] as? String ??  "unknown"
                            let reviews = restaurant["review_count"] as? Int ?? 0
                            let imageURL = restaurant["image_url"] as? String ??  "unknown"
                            
                            let newRestaurant = Restaurant(name: name, imageURL: imageURL, cost: price, reviews: reviews)
                            
                            restaurantsArray.append(newRestaurant)
                        }
                        
                        // Convert model objects to Cell View Models
                        var vms = [RestaurantCellViewModel]()
                        
                        for item in restaurantsArray {
                            vms.append(self.createCellViewModel(item: item) )
                        }
                        self.cellViewModels = vms
                    }
                    
                } catch {
                    // failed
                }
            }
            else if error != nil
            {
                // No data
            }
        })
        
        task.resume()
    }
}
