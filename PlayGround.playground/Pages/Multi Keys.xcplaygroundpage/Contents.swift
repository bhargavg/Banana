import Banana


/*:
 **Load JSON**
 
 The `array.json` file under resources is loaded for parsing
 */

guard let path = NSBundle.mainBundle().pathForResource("multi_keys", ofType: "json"),
    let data = NSData(contentsOfFile: path),
    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
        
    print("Couldn't load JSON file")
    exit(0)
}

/*:
 **Parse**
 
 As json contains an array of `Foo` values, `<<~` operator is used for parsing
 */

do {
    let value: [Foo] = try get(json) <<~ Foo.init
    print(value)
} catch {
    print("Couldn't parse JSON, error: \(error)")
}


/*:
 **Model**
 
 The values are retrieved using `get(_,keys:[String])` method, which allows us to specify multiple keys for a single value.
 */

struct Foo {
    let key: String
    
    init(json: JSON) throws {
        key = try get(json, keys: ["key", "k"])
    }
}

