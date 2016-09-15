precedencegroup BananaOperator {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator <~~ : BananaOperator
infix operator <<~ : BananaOperator


/**
 Custom operator that takes a vaule x, a function f and returns f(x)
 */

public func <~~<A, B>(x: A, f: ((A) throws -> (B))) throws -> B {
    return try f(x)
}

/**
 Custom operator that takes an array x, a function f and returns x.map(f)
 */
public func <<~<A, B>(x: [A], f: ((A) throws -> (B))) throws -> [B] {
    return try x.map(f)
}
