import Foundation

/// Casting Any? into anything else is a pain in Swift as per Swift 4.1.
/// `typecast` enum here tries various methods of casting, each having
/// a chance to succeed. Usage:
///
///    typecast<T>.any(something) // is T?
///
/// Use this in cases where `something as? T` won't work. This may help.
enum typecast<T> {
    static func any(_ v: Any?) -> T? {
        switch v {
        case .none:
            return voidCast(nil) ?? nilCast()

        case let .some(v):
            return (v as? T) ?? castAsNSObject(v) ?? voidCast(v) ?? nullCast(v)
        }
    }

    private static func castAsNSObject(_ v: Any) -> T? {
        return (v as? NSObject) as? T
    }

    private static func nilCast() -> T? {
        if T.self is ExpressibleByNilLiteral.Type {
            return ((T.self as! ExpressibleByNilLiteral.Type).init(nilLiteral: ()) as! T)
        }
        else {
            return nil
        }
    }

    private static func nullCast(_ v: Any) -> T? {
        if T.self is ExpressibleByNilLiteral.Type && v is NSNull {
            return ((T.self as! ExpressibleByNilLiteral.Type).init(nilLiteral: ()) as! T)
        }
        else {
            return nil
        }
    }

    private static func voidCast(_ v: Any?) -> T? {
        if T.self == Void.self {
            return (() as! T)
        }
        else {
            return nil
        }
    }
}
