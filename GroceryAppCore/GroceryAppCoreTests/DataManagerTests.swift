//
//  GroceryAppCoreDataManagerTests.swift
//  GroceryAppCoreTests
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import XCTest
@testable import GroceryAppCore

class DataManagerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCatalogueSearch() {

        let expectation = self.expectation(description: "catlogueSearch")

        let query = DataManagerQuery()
        DataManager.sharedInstance.catalogueSearch(query: query) { (result) in
            
            assert(result.isSuccess)
            assert(result.value != nil)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
