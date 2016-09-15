import Banana

/*:
 **Model**
 */
struct Foo {
    let key: String
    
    static func fromJSON(json: JSON) throws -> Foo {
        return try Foo(key: get(json, key: "key"))
    }
    
    static func toJSON(foo: Foo) -> JSON{
        return ["key": foo.key]
    }
}


/*:
 **Map JSON to Model**
 
 The `simple.json` file under resources is loaded for parsing
 */
// Retrieve values without model classes
let value: String = try Banana.load(file: "simple") <~~ keyPath("root.key")

// Using models
let foo: Foo =  try Banana.load(file: "simple") <~~ keyPath("root") <~~ Foo.fromJSON


/*:
 **Map Model to JSON string**
 
 `Banana.dump` is used in combination with `Banana.toString` to convert our model to a JSON string
 */
let jsonAsString = try foo <~~ Foo.toJSON <~~ Banana.dump(options: [.prettyPrinted]) <~~ Banana.toString(encoding: .utf8)
