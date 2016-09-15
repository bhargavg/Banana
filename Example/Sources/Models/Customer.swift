import Foundation
import Banana


struct Customer {
    let name: String // first_name, last_name
    let age: Int
    let gender: Gender
    let address: Address
    let skills: [String]?
    
    /// Mapping from JSON to this model
    static func fromJSON(json: JSON) throws -> Customer {
        return Customer(name: try  get(json, key: "name") <~~ Customer.getFirstLastNames <~~ Customer.createName,
                        age: try  get(json, key: "age"),
                        gender: try get(json, keys: ["gender", "g"]) <~~ Gender.parseGender,
                        address: try  get(json, key: "address") <~~ Address.fromJSON,
                        skills: try? get(json, key: "skills"))
    }
    
    static func getFirstLastNames(json: [String: Any]) throws -> (firstName: String, lastName: String) {
        let firstName: String = try get(json, key: "first_name")
        let lastName: String  = try get(json, key: "last_name")
        return (firstName, lastName)
    }
    
    static func createName(firstName: String, withLastName lastName: String) -> (String) {
        return [firstName, lastName].joined(separator: ", ")
    }
    
    
    /// Mapping from this model to JSON
    static func toJSON(customer: Customer) throws -> JSON {
        var json = JSON()
        json["name"] = customer.name
        json["age"] = customer.age
        json["gender"] = try customer.gender <~~ Gender.toJSON
        json["address"] = try customer.address <~~ Address.toJSON
        json["skills"] = customer.skills
        return json
    }
}
