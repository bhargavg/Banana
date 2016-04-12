import Banana


/*:
 **Load JSON**
 
 The `simple.json` file under resources is loaded for parsing
 */

guard let path = NSBundle.mainBundle().pathForResource("simple", ofType: "json"),
    let data = NSData(contentsOfFile: path),
    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
        
    print("Couldn't load JSON file")
    exit(0)
}

/*:
 **Parse**
 
 The value for `key` under `root` is retrieved using `keyPath` method
 */

do {
    let value: String = try get(json) <~~ keyPath("root.key")
    print(value)
} catch {
    print("Couldn't parse JSON, error: \(error)")
}


