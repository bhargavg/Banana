import Foundation

public struct Banana {
    
    /**
     Parse the given JSON file.
     
     It uses `NSJSONSerialization.JSONObjectWithData` for parsing. The parsed value,
     which is of type `AnyObject` will be casted to a type that receiver is expecting.
     
     - parameter file: Name of the JSON file without extension
     - parameter fileExtension: Optional extension of the file. Defaults to `.json`
     - parameter bundle: Optional `NSBundle` in which the file exists. Defaults to `NSBundle.mainBundle`
     
     - returns: An object of type T. This T is determined by the receiver. It tries to cast the AnyObject from `JSONObjectWithData` to a type that receiver expects.
     - throws: Throws `BananaError` if file couldn't be loaded or the value cannot be casted
     */
    public static func load<T>(file: String, fileExtension: String = "json", bundle: Bundle = Bundle.main, options: JSONSerialization.ReadingOptions = []) throws -> T {
        guard let path = bundle.path(forResource: file, ofType: fileExtension) else {
            throw BananaError<String, String>.custom("Couldn't load JSON file: \(file)")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        
        return try load(data: data, options: options)
    }
    
    /**
     Parse the given data into a JSON object.
     
     It uses `NSJSONSerialization.JSONObjectWithData` for parsing. The parsed value,
     which is of type `AnyObject` will be casted to a type that receiver is expecting.
     
     - parameter data: `NSData` object that needs to be parsed
     - parameter options: Optional `NSJSONReadingOptions` options for parsing
     
     - returns: An object of type T. This T is determined by the receiver. It tries to cast the AnyObject from `JSONObjectWithData` to a type that receiver expects.
     - throws: Throws `BananaError` if JSON couldn't be parsed, or, the value cannot be casted
     */
    public static func load<T>(data: Data, options: JSONSerialization.ReadingOptions = []) throws -> T {
        return try JSONSerialization.jsonObject(with: data, options: options) <~~ get
    }
    
    /**
     Encode the given `jsonObject` into NSData
     
     It uses `NSJSONSerialization.dataWithJSONObject` for encoding.
     
     - note: This is a curried function. It first takes the `NSJSONWritingOptions` and returns a closure.
     This closure takes the `jsonObject` and encodes it into NSData with the options previously provided.
     
     - parameter options: `NSJSONWritingOptions` used for encoding
     - parameter jsonObject: Object to encode
     
     - returns: Encoded value in the form of `NSData`
     
     - throws: `BananaError` if the value cannot be encoded
    */
    public static func dump(options: JSONSerialization.WritingOptions) -> (_ jsonObject: Any) throws -> Data {
        return  { jsonObject in
            return try Banana.dump(JSONObject: jsonObject, options: options)
        }
    }
    
    /**
     Encode the given `jsonObject` into NSData
     
     It uses `NSJSONSerialization.dataWithJSONObject` for encoding.
     
     - parameter jsonObject: Object to encode
     - parameter options: `NSJSONWritingOptions` used for encoding
     
     - returns: Encoded value in the form of `NSData`
     
     - throws: `BananaError` if the value cannot be encoded
     */
    public static func dump(JSONObject jsonObject: Any, options: JSONSerialization.WritingOptions) throws -> Data {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: options) else {
            throw BananaError<String, String>.custom("Couldn't convert JSON Object to NSData")
        }
        
        return jsonData
    }
    
    
    /**
     Convert the given `NSData` into an `NSString` with given `encoding`
     
     It uses `NSString(data:encoding:)` for the conversion.
     
     - note: This is a curried function. It first takes `encoding` parameter and returns a closure.
     This closure takes the actual data to convert and returns the `NSString` of it.
     
     - parameter encoding: `NSStringEncoding` to be used for conversion
     - parameter data: `NSData` that needs to be converted
     
     - returns: Converted value in the form of `NSString`
     
     - throws: `BananaError` if `NSString` object cannot be made
     */
    public static func toString(encoding: String.Encoding) -> (_ data: Data) throws -> String {
        return { data in
            guard let string = String(data: data, encoding: encoding) else {
                throw BananaError<String, String>.custom("Couldn't convert to NSString")
            }
            
            return string
        }
    }
}
