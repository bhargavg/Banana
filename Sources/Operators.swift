infix operator <~~ {
    associativity left
    precedence 110
}

infix operator <<~ {
    associativity left
    precedence 110
}

public func <~~<A, B>(x: A, f: (A throws -> B)) throws -> B {
    return try f(x)
}

public func <<~<A, B>(x: [A], f: (A throws -> B)) throws -> [B] {
    return try x.map(f)
}
