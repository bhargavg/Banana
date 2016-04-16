//
//  PerfTests.swift
//  Banana
//
//  Created by Bhargav Gurlanka on 4/13/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import XCTest
import Banana

class PerfTests: XCTestCase {
    
    func testPerformanceExample() {
        let json: [String: AnyObject] = try! Banana.load(file: "personWithTODOItems", fileExtension: "json", bundle: NSBundle(forClass: PerfTests.self))
        
        self.measureBlock {
            for _ in 0...1_000 {
                let _ = try! json <~~ Person.parse
            }
        }
    }
    
    
    struct Person {
        let name: String
        let age: Int
        let gender: Gender
        let homePinCode: String?
        let todoItems: [TodoItem]
        
        static func parse(json: JSON) throws -> Person {
            return Person(name: try get(json, key: "name"),
                          age: try get(json, key: "age"),
                          gender: try get(json, key: "gender") <~~ Gender.parse,
                          homePinCode: try? get(json, key: "address")  <~~ keyPath("home.pincode"),
                          todoItems: try get(json, key: "todo_items") <<~ TodoItem.parse)
        }
    }
    
    struct TodoItem {
        let id: String
        let title: String
        let isCompleted: Bool
        
        static func parse(json: JSON) throws -> TodoItem {
            return TodoItem(id: try get(json, key: "id"),
                            title: try get(json, key: "title"),
                            isCompleted: try get(json, key: "is_completed"))
        }
    }
    
    enum Gender {
        case Male, Female
        
        static func parse(value: String) throws -> Gender {
            switch value {
            case "male":
                return .Male
            case "female":
                return .Female
            default:
                throw BananaError<String, String>.Custom("Invalid Gender: \(value)")
            }
        }
    }
}
