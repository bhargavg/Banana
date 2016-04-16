import Banana

/*:
 **Model**
 
 The values are retrieved using `get(_,key:String)` method.
 */
struct Foo {
    let key: String
    
    static func fromJSON(json: JSON) throws -> Foo {
        return try Foo(key: get(json, key: "key"))
    }
    
    static func toJSON(foo: Foo) throws -> JSON {
        return ["key": foo.key]
    }
}

/*:
 **Map JSON to Model**
 
 The `array.json` file under resources is loaded
 */
let foos: [Foo] = try Banana.load(file: "array") <<~ Foo.fromJSON

/*:
 **Map Model to JSON string**
 
 As json contains an array of `Foo` values, `<<~` operator is used for mapping
 */

let fooAsJSONString = try foos <<~ Foo.toJSON <~~ Banana.dump(options: []) <~~ Banana.toString(encoding: NSUTF8StringEncoding)