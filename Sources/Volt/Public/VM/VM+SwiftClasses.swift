// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension VM {
    @discardableResult
    public func defineClass0<T>(initializer: @escaping () -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc0(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass1<T, P0>(initializer: @escaping (P0) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc1(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass2<T, P0, P1>(initializer: @escaping (P0, P1) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc2(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass3<T, P0, P1, P2>(initializer: @escaping (P0, P1, P2) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc3(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass4<T, P0, P1, P2, P3>(initializer: @escaping (P0, P1, P2, P3) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc4(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass5<T, P0, P1, P2, P3, P4>(initializer: @escaping (P0, P1, P2, P3, P4) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc5(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass6<T, P0, P1, P2, P3, P4, P5>(initializer: @escaping (P0, P1, P2, P3, P4, P5) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc6(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass7<T, P0, P1, P2, P3, P4, P5, P6>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc7(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass8<T, P0, P1, P2, P3, P4, P5, P6, P7>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc8(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass9<T, P0, P1, P2, P3, P4, P5, P6, P7, P8>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc9(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass10<T, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc10(named: String(describing: T.self), func: initializer)
        return continueDefiningClass(T.self)
    }

    private func continueDefiningClass<T>(_ type: T.Type) -> AnyTypeDelegate<T> {
        let delegate = DefaultTypeDelegate<T>()
        typeDelegates.registerTypeDelegate(delegate)
        return .init(delegate)
    }
}
