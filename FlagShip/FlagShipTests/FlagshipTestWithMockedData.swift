//
//  FlagshipTestWithMockedData.swift
//  FlagshipTests
//
//  Created by Adel on 29/05/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import XCTest
@testable import Flagship


class FlagshipTestWithMockedData: XCTestCase {

     var flagShipMock:FlagshipMock!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        flagShipMock = FlagshipMock()
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
    
    
    
    
    func testStartMock(){
        
        let expectation = self.expectation(description: #function)
        
        flagShipMock.start(envId: "bkk9glocmjcg0vtmdlng", apiKey: "apikey", visitorId: "userID") { (result) in
            
            
            let array = Flagship.sharedInstance.getModification("array", defaultArray: ["Error"])
            
            XCTAssert(array.count == 3)
            
              expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
     }
    
    
    

}
