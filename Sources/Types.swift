
public typealias JSON = [String: AnyObject]

public enum ParseError<T, U>: ErrorType {
    case InvalidType(T, expected: U)
    case NilValue(T)
    case Custom(T)
}

extension ParseError: CustomStringConvertible {
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