import Banana

struct Address {
    let street: String
    let city: String
    let state: String?
    
    init(json: JSON) throws {
        street = try  get(json, key: "street")
        city   = try  get(json, key: "city")
        state  = try? get(json, key: "state")
    }
}