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
        let json = Utils.loadJSON("person")
        
        do {
            let person = try get(json) <~~ Person.init
            
            XCTAssert(person.name == "Bob")
            XCTAssert(person.age == 25)
            XCTAssert(person.gender == .Male)
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
        
        init(json: JSON) throws {
            name = try get(json, key: "name")
            age = try get(json, key: "age")
            gender = try get(json, key: "gender") <~~ Gender.init
            address = try? get(json, key: "address")
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
