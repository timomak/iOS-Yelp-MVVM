//
//  ViewModel.swift
//  Yelp-MVVM-Example
//
//  Created by timofey makhlay on 11/30/20.
//

import Foundation


import UIKit

class RestaurantViewModel {
    
    /// Raw data is stored here
    private var restaurants: [Restaurant]!
    
    /// Repurposed data  for Cells
    private var cellViewModels: [RestaurantCellViewModel] = [RestaurantCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    /// Return the number of cell view models
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    /// Return closure for Completion closures (unused here)
    var reloadCollectionViewClosure: (()->())?
    
    /// Return cell at index value
    func getCellViewModel(at indexPath: IndexPath ) -> RestaurantCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    /// Create cell view model from Onboarding Raw data
    func createCellViewModel(item: Restaurant) -> RestaurantCellViewModel {
        
        return RestaurantCellViewModel(name: item.name, imageURL: item.imageURL, cost: item.cost, reviews: item.reviews)
    }
    
    func getRestaurantRequest() {
        
        let params: [String:String] = [
            "term": "Pasta",
            "location": "San Francisco"
        ]
        
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
            print("Data: \(data), response: \(response), error: \(error)")
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    print("Json: ", json)
                    
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
                        
                        print("successfully downloaded all objects")
                        
                        var vms = [RestaurantCellViewModel]()
                        
                        for item in restaurantsArray {
                            vms.append(self.createCellViewModel(item: item) )
                        }
                        self.cellViewModels = vms
                        self.reloadCollectionViewClosure?()
                        
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
    
    
    //
    //    /// Get all pages
    //    func createPages() {
    //
    //        let session = URLSession.shared
    //                let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    //                let task = session.dataTask(with: url, completionHandler: { data, response, error in
    //                    // Check the response
    //                    print(response)
    //
    //                    // Check if an error occured
    //                    if error != nil {
    //                        // HERE you can manage the error
    //                        print(error)
    //                        return
    //                    }
    //
    //                    // Serialize the data into an object
    //                    do {
    //                        let json = try JSONDecoder().decode([Post].self, from: data! )
    //                            //try JSONSerialization.jsonObject(with: data!, options: [])
    //                        print(json)
    //                    } catch {
    //                        print("Error during JSON serialization: \(error.localizedDescription)")
    //                    }
    //
    //                })
    //                task.resume()
    //
    ////        let items = [
    ////            Onboard(centerImgName: "Scangiphy", description: "1. Scan any receipt or bill", isGif: true),
    ////            Onboard(centerImgName: "manualGiphy", description: "2. Assign items to friends", isGif: true),
    ////            Onboard(centerImgName: "venmoText", description: "3. Send request!", isGif: false)
    ////        ]
    //
    //        var vms = [RestaurantCellViewModel]()
    //
    //        for item in items {
    //            vms.append(createCellViewModel(item: item) )
    //        }
    //        self.cellViewModels = vms
    ////        self.reloadCollectionViewClosure?()
    //    }
}
