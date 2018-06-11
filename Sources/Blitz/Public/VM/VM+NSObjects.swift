// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation

extension VM {
    @discardableResult
    public func defineNSObject0<T: NSObject>
                               (selector rawSelector: String = "\(String(describing: T.self))()",
                                initializer: @escaping () -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc0(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject1<T: NSObject, P0>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:)",
                                initializer: @escaping (P0) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc1(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject2<T: NSObject, P0, P1>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:)",
                                initializer: @escaping (P0, P1) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc2(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject3<T: NSObject, P0, P1, P2>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:)",
                                initializer: @escaping (P0, P1, P2) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc3(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject4<T: NSObject, P0, P1, P2, P3>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc4(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject5<T: NSObject, P0, P1, P2, P3, P4>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3, P4) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc5(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject6<T: NSObject, P0, P1, P2, P3, P4, P5>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3, P4, P5) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc6(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject7<T: NSObject, P0, P1, P2, P3, P4, P5, P6>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3, P4, P5, P6) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc7(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject8<T: NSObject, P0, P1, P2, P3, P4, P5, P6, P7>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc8(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject9<T: NSObject, P0, P1, P2, P3, P4, P5, P6, P7, P8>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc9(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    @discardableResult
    public func defineNSObject10<T: NSObject, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9>
                               (selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:_:_:_:)",
                                initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> T) -> AnyTypeDelegate<T> {
            defineGlobalFunc10(selector: rawSelector, func: initializer)
            return continueDefinigNSObject(T.self)
    }

    private func continueDefinigNSObject<T: NSObject>(_ type: T.Type) -> AnyTypeDelegate<T> {
        let delegate = NSObjectTypeDelegate<T>()
        typeDelegates.registerTypeDelegate(delegate)
        return .init(delegate)
    }
}
