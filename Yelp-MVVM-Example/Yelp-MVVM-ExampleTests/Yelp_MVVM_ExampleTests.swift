//
//  Yelp_MVVM_ExampleTests.swift
//  Yelp-MVVM-ExampleTests
//
//  Created by timofey makhlay on 11/30/20.
//

import XCTest
@testable import Yelp_MVVM_Example

class Yelp_MVVM_ExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Check if the model properly converts the data
    func testViewModelConversion() {
        /// View model property
        let viewModel: RestaurantViewModel = RestaurantViewModel()
        
        // Example of model
        let exampleModel = Restaurant(name: "Make School", imageURL: "https://images.hired.com/companies/7115/logos/1418338709/offer.png", cost: "0", reviews: 0)
        
        let cellViewModel = viewModel.createCellViewModel(item: exampleModel)
        
        XCTAssertEqual(cellViewModel.descriptionText, "\(exampleModel.cost), \(exampleModel.reviews) Reviews") // text is moved properly onto the viewModel
    }
}
