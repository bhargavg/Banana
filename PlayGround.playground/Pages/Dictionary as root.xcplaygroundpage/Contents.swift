import Banana

/*:
 **Model**
 */
struct Foo {
    let key: String
    
    static func fromJSON(json: JSON) throws -> Foo {
        return Foo(key: try get(json, key: "key"))
    }
    
    static func toJSON(foo: Foo) -> JSON {
        return ["key": foo.key]
    }
}

/*:
 **Map JSON to Model**
 
 The `array.json` file under resources is loaded
 */
let foo = try Banana.load(file: "dictionary") <~~ Foo.fromJSON

/*:
 **Map Model to JSON string**
 
 As json contains `Foo` as dictionary, `<~~` operator is used for mapping
 */

let fooAsJSONString = try foo <~~ Foo.toJSON <~~ Banana.dump(options: []) <~~ Banana.toString(encoding: NSUTF8StringEncoding)