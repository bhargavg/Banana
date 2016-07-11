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
#if swift(>=3.0)
    public static func load<T>(file: String, fileExtension: String = "json", bundle: Bundle = Bundle.main, options: JSONSerialization.ReadingOptions = []) throws -> T {
        guard let path = bundle.pathForResource(file, ofType: fileExtension),
              let data = NSData(contentsOfFile: path) else {
            throw BananaError<String, String>.Custom("Couldn't load JSON file: \(file)")
        }
        
        return try load(data: data, options: options)
    }
#else
    public static func load<T>(file file: String, fileExtension: String = "json", bundle: NSBundle = NSBundle.mainBundle(), options: NSJSONReadingOptions = []) throws -> T {
        guard let path = bundle.pathForResource(file, ofType: fileExtension),
              let data = NSData(contentsOfFile: path) else {
            throw BananaError<String, String>.Custom("Couldn't load JSON file: \(file)")
        }
    
        return try load(data: data, options: options)
    }
#endif
    
    /**
     Parse the given data into a JSON object.
     
     It uses `NSJSONSerialization.JSONObjectWithData` for parsing. The parsed value,
     which is of type `AnyObject` will be casted to a type that receiver is expecting.
     
     - parameter data: `NSData` object that needs to be parsed
     - parameter options: Optional `NSJSONReadingOptions` options for parsing
     
     - returns: An object of type T. This T is determined by the receiver. It tries to cast the AnyObject from `JSONObjectWithData` to a type that receiver expects.
     - throws: Throws `BananaError` if JSON couldn't be parsed, or, the value cannot be casted
     */
#if swift(>=3.0)
    public static func load<T>(data: NSData, options: JSONSerialization.ReadingOptions = []) throws -> T {
        return try JSONSerialization.jsonObject(with: data as Data, options: options) <~~ get
    }
#else
    public static func load<T>(data data: NSData, options: NSJSONReadingOptions = []) throws -> T {
        return try NSJSONSerialization.JSONObjectWithData(data, options: options) <~~ get
    }
#endif
    
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
#if swift(>=3.0)
    public static func dump(options: JSONSerialization.WritingOptions) -> (jsonObject: AnyObject) throws -> NSData {
        return  { jsonObject in
            return try Banana.dump(JSONObject: jsonObject, options: options)
        }
    }
#else
    public static func dump(options options: NSJSONWritingOptions) -> (jsonObject: AnyObject) throws -> NSData {
        return  { jsonObject in
            return try Banana.dump(JSONObject: jsonObject, options: options)
        }
    }
#endif
    
    
    /**
     Encode the given `jsonObject` into NSData
     
     It uses `NSJSONSerialization.dataWithJSONObject` for encoding.
     
     - parameter jsonObject: Object to encode
     - parameter options: `NSJSONWritingOptions` used for encoding
     
     - returns: Encoded value in the form of `NSData`
     
     - throws: `BananaError` if the value cannot be encoded
     */
#if swift(>=3.0)
    public static func dump(JSONObject jsonObject: AnyObject, options: JSONSerialization.WritingOptions) throws -> NSData {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: options) else {
            throw BananaError<String, String>.Custom("Couldn't convert JSON Object to NSData")
        }
        
        return jsonData
    }
#else
    public static func dump(JSONObject jsonObject: AnyObject, options: NSJSONWritingOptions) throws -> NSData {
        guard let jsonData = try? NSJSONSerialization.dataWithJSONObject(jsonObject, options: options) else {
            throw BananaError<String, String>.Custom("Couldn't convert JSON Object to NSData")
        }
    
        return jsonData
    }
#endif
    
    
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
#if swift(>=3.0)
    public static func toString(encoding: String.Encoding) -> (data: NSData) throws -> NSString {
        return { data in
            guard let string = NSString(data: data as Data, encoding:  encoding.rawValue) else {
                throw BananaError<String, String>.Custom("Couldn't convert to NSString")
            }
            
            return string
        }
    }
#else
    public static func toString(encoding encoding: NSStringEncoding) -> (data: NSData) throws -> NSString {
        return { data in
            guard let string = NSString(data: data, encoding:  encoding) else {
                throw BananaError<String, String>.Custom("Couldn't convert to NSString")
            }
    
            return string
        }
    }
#endif
}
