//
//  HomeViewModel_Tests.swift
//  Laterr_Tests
//
//  Created by Pavel Raspaev on 19.06.2022.
//

import XCTest
@testable import Laterr

class HomeViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeViewModel_tasks_shouldHaveTaskModelArray() {
        // Given
        let task = [Task]()
        
        // When
        let tasks = HomeViewModel().tasks
        
        //  Then
        XCTAssertTrue(type(of: task) == type(of: tasks))
    }

}
