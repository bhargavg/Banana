import Foundation

/**
 A function to get the value from given JSON dictonary and cast it to the type that 
 receiver expects.
 
 - parameter box: A JSON dictionary
 - parameter key: A key whose value is required
 - returns: The type casted value of `key` from `box`
 
 - throws: `BananaError` if the key is not found or the value cannot be casted.
 */
public func get<T>(_ box: JSON, key: String) throws -> T {
    typealias BananaErrorType = BananaError<String, T.Type>
    
    guard let value = box[key] else {
        throw BananaErrorType.nilValue(key)
    }
    
    return try get(value)
}

/**
 A function to get the value from given JSON ditionary and cast it to the type that 
 receiver expects.
 
 - parameter box: A JSON dictionary
 - parameter keyPath: A key path whose value is required
 - returns: the type casted value of `keyPath` from `box`
 
 - throws:`BananaError` if the key is not found or the value cannot be casted.
 */
public func get<T>(_ box: JSON, keyPath path: String) throws -> T {
    return try get(box) <~~ keyPath(path)
}


/**
 A function to get the value from given JSON dictonary and cast it to the type that
 receiver expects.
 
 This function is exactly similar to `get(box:key:)`, except that now it takes an array
 of keys instead of a single value.
 
 - parameter box: A JSON dictionary
 - parameter keys: A set of keys to try for a value. All the keys will be tried 
 and the first successfull value will be returned.
 - returns: The type casted value of `key` from `box`
 
 - throws: `BananaError` if non keys are provided, or, the JSON doesn't have any of the
 keys, or, values could'nt be casted
 */

public func get<T>(_ box: JSON, keys: [String]) throws -> T {
    typealias BananaErrorType = BananaError<String, T.Type>
    
    guard !keys.isEmpty else {
        throw BananaErrorType.custom("Should provide at least one key")
    }
    
    var errors:[BananaErrorType] = []
    
    for key in keys {
        do {
            let value: T = try get(box, key: key)
            return value
        } catch {
            if let err = error as? BananaErrorType {
                errors.append(err)
            } else {
                errors.append(.custom("Unknown error occured while processing keys: \(keys)"))
            }
        }
    }
    
    guard let lastError = errors.last else {
        throw BananaErrorType.custom("Unknown error occured while processing keys: \(keys)")
    }
    
    for error in errors {
        if case .nilValue = error {
            continue;
        } else {
            throw lastError
        }
    }
    
    let joinedKeys = keys.map{ "\"" + $0 + "\"" }.joined(separator: ", ")

    throw BananaErrorType.custom("No values found for keys: \(joinedKeys) \nin: \n\(box)")
}


/**
 Cast the given input into required type.
 
 The required type is deduced from the receiver.
 
 - parameter item: Object to cast
 - returns: Casted value
 
 - throws: Throws `BananaError` if the value cannot be casted.
 */
public func get<T>(_ item: Any) throws -> T {
    guard let typedItem = item as? T else {
        throw BananaError.invalidType(item, expected: T.self)
    }
    
    return typedItem
}

/**
 Get the value of a keypath from given dictonary.
 
 This function works by casting the given dictionary into `NSDictionary` and using
 `valueForKeyPath` to get the value. The retrieved value will be casted to the type
 that receiver expects.
 
 - note: This is a curried function. First, it takes a keypath and returns a closure.
 This returned closure takes a dictionary and returns the value of the keypath in that
 dictionary.
 
 - parameter path: A key path
 - parameter box: A dictionary
 - returns: Value of the given key path, casted to required type
 
 - throws: `BananaError` if the dictionary doesn't have a key path or 
 the value cannot be casted.
 */
public func keyPath<T>(_ path: String) -> (_ box: JSON) throws -> T {
    typealias BananaErrorType = BananaError<String, T.Type>
    
    return { box in
        guard let value = (box as NSDictionary).value(forKeyPath: path) else {
            throw BananaErrorType.nilValue(path)
        }
        return try get(value)
    }
}
