import Foundation
import Banana


struct Customer {
    let name: String // first_name, last_name
    let age: Int
    let gender: Gender
    let address: Address
    let skills: [String]?
    
    init(json: JSON) throws {
        name    =  try  get(json, key: "name")    <~~ Customer.getFirstLastNames <~~ Customer.createName
        age     =  try  get(json, key: "age")
        gender  =  try  get(json, keys: ["gender", "g"])  <~~ Gender.parseGender
        address =  try  get(json, key: "address") <~~ Address.init
        skills  =  try? get(json, key: "skills")
    }
    
    static func getFirstLastNames(json: [String: AnyObject]) throws -> (firstName: String, lastName: String) {
        let firstName: String = try get(json, key: "first_name")
        let lastName: String  = try get(json, key: "last_name")
        return (firstName, lastName)
    }
    
    static func createName(firstName: String, withLastName lastName: String) -> (String) {
        return [firstName, lastName].joinWithSeparator(", ")
    }
}
