//
//  CoffeeMeetsBagelTeamTests.swift
//  CoffeeMeetsBagelTeamTests
//
//  Created by Komran Ghahremani on 6/5/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import XCTest
@testable import CoffeeMeetsBagelTeam

class CoffeeMeetsBagelTeamTests: XCTestCase {
    let failedMockAPIManager = MockAPI(resultType: .failure)
    let successMockAPIManager = MockAPI(resultType: .success(
        [
            [
            "avatar": "https://media.licdn.com/media/AAEAAQAAAAAAAAPuAAAAJDcxZGJjZDlhLTYzMjUtNDFhZi1hYzFjLWM1MmEzNGVlODRmMw.jpg",
            "bio": "Biotesting",
            "firstName": "Komran",
            "id": "0",
            "lastName": "Ghahremani",
            "title": "Trying to get a job"
            ],
            [
            "avatar": "https://media.licdn.com/media/AAEAAQAAAAAAAAPuAAAAJDcxZGJjZDlhLTYzMjUtNDFhZi1hYzFjLWM1MmEzNGVlODRmMw.jpg",
            "bio": "Biotesting",
            "firstName": "Komran",
            "id": "0",
            "lastName": "Ghahremani",
            "title": "Trying to get a job"
            ]
        ]
    ))
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSuccessfulItemReturned() {
        let mockView = MockEmployeeListView()
        let mockViewModel = TeamViewModel(view: mockView, successMockAPIManager)
        
        mockViewModel.fetchEmployeeData()
        
        XCTAssertTrue(mockView.dataDidLoadCalled)
        XCTAssertFalse(mockView.errorPromptCalled)
    }
    
    func testFailedItemReturned() {
        let mockView = MockEmployeeListView()
        let mockViewModel = TeamViewModel(view: mockView, failedMockAPIManager)
        
        mockViewModel.fetchEmployeeData()
        
        XCTAssertTrue(mockView.errorPromptCalled)
        XCTAssertFalse(mockView.dataDidLoadCalled)
    }
    
}
