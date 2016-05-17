/// A type to represent typical JSON
public typealias JSON = [String: AnyObject]

/// Enumeration to represent Banana Errors.
public enum BananaError<T, U>: ErrorProtocol {
    /// Case when the value is of different type than expected
    case InvalidType(T, expected: U)
    /// Case when a value is nil
    case NilValue(T)
    /// Custom error case
    case Custom(T)
}

extension BananaError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .InvalidType(let aThing, let expectedType):
            return "\(aThing) is not of type: \(expectedType)"
        case .NilValue(let key):
            return "\(key) is nil"
        case .Custom(let thingy):
            return "\(thingy)"
        }
    }
}