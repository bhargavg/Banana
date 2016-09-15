//
//  BananaTests.swift
//  BananaTests
//
//  Created by Bhargav Gurlanka on 4/13/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import XCTest
import Banana

class GetTests: XCTestCase {
    
    func testGetInt() {
        let anyInt = 5

        do {
            let value: Int = try get(anyInt)
            XCTAssertTrue(value == 5)
        } catch {
            XCTFail("Integer casting failed")
        }
    }
    
    func testGetString() {
        let anyString = "My String"
        
        do {
            let value: String = try get(anyString)
            XCTAssertTrue(value == "My String")
        } catch {
            XCTFail("String casting failed")
        }
    }
    
    func testGetBool() {
        let anyBool = true

        do {
            let value: Bool = try get(anyBool)
            XCTAssertTrue(value == true)
        } catch {
            XCTFail("Integer casting failed")
        }
    }
    
    func testKeyPath() {
        do {

            let rawJSON: JSON = try Banana.load(file: "personWithTODOItems", fileExtension: "json", bundle: Bundle(for: GetTests.self))
            
            let stringKey: String = try get(rawJSON, keyPath: "address.home.street")
            let boolKey: Bool = try get(rawJSON, keyPath: "address.office.is_active")
            
            XCTAssertTrue(stringKey == "17/B, Bank Road")
            XCTAssertTrue(boolKey == false)
        } catch {
            XCTFail("Failed with error: \(error)")
        }
    }
}
