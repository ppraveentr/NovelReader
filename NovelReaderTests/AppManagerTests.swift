//
//  AppManagerTests.swift
//  NovelReaderTests
//
//  Created by Praveen Prabhakar on 25/12/20.
//  Copyright © 2020 Praveen Prabhakar. All rights reserved.
//

@testable import NovelReader
import XCTest

class AppManagerTests: XCTestCase {
    func testManager() throws {
        // let
        let manager = AppManager.sharedInstance
        XCTAssertNotNil(manager, "Should not be nil")
    }
}
