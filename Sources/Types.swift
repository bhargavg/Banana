/// A type to represent typical JSON
public typealias JSON = [String: Any]

/// Enumeration to represent Banana Errors.
public enum BananaError<T, U>: Error {
    /// Case when the value is of different type than expected
    case invalidType(T, expected: U)
    /// Case when a value is nil
    case nilValue(T)
    /// Custom error case
    case custom(T)
}

extension BananaError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidType(let aThing, let expectedType):
            return "\(aThing) is not of type: \(expectedType)"
        case .nilValue(let key):
            return "\(key) is nil"
        case .custom(let thingy):
            return "\(thingy)"
        }
    }
}
