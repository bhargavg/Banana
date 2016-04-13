public func get<T>(box: JSON, key: String) throws -> T {
    
    typealias ParseErrorType = ParseError<String, T.Type>
    
    guard let value = box[key] else {
        throw ParseErrorType.NilValue(key)
    }
    
    return try get(value)
}

public func get<T>(box: JSON, keys: [String]) throws -> T {
    
    typealias ParseErrorType = ParseError<String, T.Type>
    
    guard !keys.isEmpty else {
        throw ParseErrorType.Custom("Should provide at least one key")
    }
    
    var errors:[ParseErrorType] = []
    
    for key in keys {
        do {
            let value: T = try get(box, key: key)
            return value
        } catch {
            if let err = error as? ParseErrorType {
                errors.append(err)
            } else {
                errors.append(.Custom("Unknown error occured while processing keys: \(keys)"))
            }
        }
    }
    
    guard let lastError = errors.last else {
        throw ParseErrorType.Custom("Unknown error occured while processing keys: \(keys)")
    }
    
    for error in errors {
        if case .NilValue = error {
            continue;
        } else {
            throw lastError
        }
    }
    
    let joinedKeys = keys.map{ "\"" + $0 + "\"" }.joinWithSeparator(", ")
    throw ParseErrorType.Custom("No values found for keys: \(joinedKeys) \nin: \n\(box)")
}

public func get<T>(item: AnyObject) throws -> T {
    guard let typedItem = item as? T else {
        throw ParseError.InvalidType(item, expected: T.self)
    }
    
    return typedItem
}


public func keyPath<T>(path: String) -> (box: JSON) throws -> T {
    
    typealias ParseErrorType = ParseError<String, T.Type>
    
    return { box in
        guard let value = (box as NSDictionary).valueForKeyPath(path) else {
            throw ParseErrorType.NilValue(path)
        }
        
        return try get(value)
    }
}