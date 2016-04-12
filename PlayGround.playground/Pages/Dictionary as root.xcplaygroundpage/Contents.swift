import Banana

/*:
 **Load JSON**
 
 The `dictionary.json` file under resources is loaded for parsing
 */

guard let path = NSBundle.mainBundle().pathForResource("dictionary", ofType: "json"),
    let data = NSData(contentsOfFile: path),
    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
        
    print("Couldn't load JSON file")
    exit(0)
}

/*:
 **Parse**
 
 As json contains a dictionary, `<~~` operator is used for parsing
 */

do {
    let value: Foo = try get(json) <~~ Foo.init
    print(value)
} catch {
    print("Couldn't parse JSON, error: \(error)")
}

/*:
 **Model**
 */

struct Foo {
    let key: String
    
    init(json: JSON) throws {
        key = try get(json, key: "key")
    }
}

