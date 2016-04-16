import Banana

struct Address {
    let street: String
    let city: String
    let state: String?

    /// Mapping from JSON to this model
    static func fromJSON(json: JSON) throws -> Address {
        return Address(street: try  get(json, key: "street"),
                       city:   try  get(json, key: "city"),
                       state:  try? get(json, key: "state"))
    }
    
    /// Mapping from this model to JSON
    static func toJSON(address: Address) throws -> JSON {
        var json = JSON()
        json["street"] = address.street
        json["city"] = address.city
        json["state"] = address.state
        return json
    }
}