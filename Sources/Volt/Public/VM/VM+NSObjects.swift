import Foundation

extension VM {
    public func defineNSObject0<T: NSObject>(initializer: @escaping () -> T) throws {
        try defineGlobalFunc0(named: String(describing: T.self), func: initializer)
        continueDefinigNSObject(T.self)
    }

    public func defineNSObject1<T: NSObject, P0>(initializer: @escaping (P0) -> T) throws {
        try defineGlobalFunc1(named: String(describing: T.self), func: initializer)
        continueDefinigNSObject(T.self)
    }

    public func defineNSObject2<T: NSObject, P0, P1>(initializer: @escaping (P0, P1) -> T) throws {
        try defineGlobalFunc2(named: String(describing: T.self), func: initializer)
        continueDefinigNSObject(T.self)
    }

    public func defineNSObject3<T: NSObject, P0, P1, P2>(initializer: @escaping (P0, P1, P2) -> T) throws {
        try defineGlobalFunc3(named: String(describing: T.self), func: initializer)
        continueDefinigNSObject(T.self)
    }

    public func defineNSObject4<T: NSObject, P0, P1, P2, P3>(initializer: @escaping (P0, P1, P2, P3) -> T) throws {
        try defineGlobalFunc4(named: String(describing: T.self), func: initializer)
        continueDefinigNSObject(T.self)
    }

    private func continueDefinigNSObject<T: NSObject>(_ type: T.Type) {
        typeDelegates.registerTypeDelegate(NSObjectTypeDelegate<T>())
    }
}
