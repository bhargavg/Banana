import Banana

/*:
 **Model**
 
 The values are retrieved using `get(_,keys:[String])` method, which allows us to specify multiple keys for a single value.
 */
struct Foo {
    let key: String
    
    static func fromJSON(json: JSON) throws -> Foo {
        return Foo(key: try get(json, keys: ["key", "k"]))
    }
}

/*:
 **Map JSON to Model**
 
 The `multi_keys.json` file under resources is loaded for parsing
 */
let foos: [Foo] = try Banana.load(file: "multi_keys") <<~ Foo.fromJSON
