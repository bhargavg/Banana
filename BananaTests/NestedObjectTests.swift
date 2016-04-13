//
//  BananaNestedObjectTests.swift
//  Banana
//
//  Created by Bhargav Gurlanka on 4/13/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import XCTest
import Banana

class NestedObjectTests: XCTestCase {
    
    func testParsing() {
        let json = Utils.loadJSON("personWithTODOItems")
        
        do {
            let person = try get(json) <~~ Person.init
            
            XCTAssert(person.name == "Bob")
            XCTAssert(person.age == 25)
            XCTAssert(person.gender == .Male)
            XCTAssert(person.homePinCode == "135335")
            
        } catch {
            XCTFail("Parsing failed with error: \(error)")
        }
    }
    
    struct Person {
        let name: String
        let age: Int
        let gender: Gender
        let homePinCode: String?
        let todoItems: [TodoItem]
        
        init(json: JSON) throws {
            name = try get(json, key: "name")
            age = try get(json, key: "age")
            gender = try get(json, key: "gender") <~~ Gender.init
            homePinCode = try? get(json, key: "address") <~~ keyPath("home.pincode")
            todoItems = try get(json, key: "todo_items") <<~ TodoItem.init
        }
    }
    
    struct TodoItem {
        let id: String
        let title: String
        let isCompleted: Bool
        
        init(json: JSON) throws {
            id = try get(json, key: "id")
            title = try get(json, key: "title")
            isCompleted = try get(json, key: "is_completed")
        }
    }
    
    enum Gender {
        case Male, Female
        
        init(fromString: String) throws {
            switch fromString {
            case "male":
                self = .Male
            case "female":
                self = .Female
            default:
                throw ParseError<String, String>.Custom("Invalid Gender: \(fromString)")
            }
        }
    }
    
}
