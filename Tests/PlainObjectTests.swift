//
//  BananaParsingTests.swift
//  Banana
//
//  Created by Bhargav Gurlanka on 4/13/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import XCTest
import Banana

class ParsingTests: XCTestCase {
    
    func testParsing() {
        do {
            let person = try Banana.load(file: "person", fileExtension: "json", bundle: Bundle(for: GetTests.self)) <~~ Person.fromJSON
            
            XCTAssert(person.name == "Bob")
            XCTAssert(person.age == 25)
            XCTAssert(person.gender == .male)
            XCTAssert(person.address == nil)
            
        } catch {
            XCTFail("Parsing failed with error: \(error)")
        }
    }
    
    struct Person {
        let name: String
        let age: Int
        let gender: Gender
        let address: String?
        
        static func fromJSON(json: JSON) throws -> Person {
            return Person(name: try get(json, key: "name"),
                          age: try get(json, key: "age"),
                          gender: try get(json, key: "gender") <~~ Gender.parse,
                          address: try? get(json, key: "address"))
        }
    }
    
    enum Gender {
        case male, female
        
        static func parse(value: String) throws -> Gender {
            switch value {
            case "male":
                return .male
            case "female":
                return .female
            default:
                throw BananaError<String, String>.custom("Invalid Gender: \(value)")
            }
        }
    }
}
