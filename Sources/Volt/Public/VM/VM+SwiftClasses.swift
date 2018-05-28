// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension VM {
    @discardableResult
    public func defineClass0<T>(selector rawSelector: String, initializer: @escaping () -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc0(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass1<T, P0>(selector rawSelector: String, initializer: @escaping (P0) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc1(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass2<T, P0, P1>(selector rawSelector: String, initializer: @escaping (P0, P1) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc2(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass3<T, P0, P1, P2>(selector rawSelector: String, initializer: @escaping (P0, P1, P2) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc3(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass4<T, P0, P1, P2, P3>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc4(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass5<T, P0, P1, P2, P3, P4>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3, P4) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc5(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass6<T, P0, P1, P2, P3, P4, P5>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3, P4, P5) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc6(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass7<T, P0, P1, P2, P3, P4, P5, P6>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3, P4, P5, P6) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc7(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass8<T, P0, P1, P2, P3, P4, P5, P6, P7>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc8(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass9<T, P0, P1, P2, P3, P4, P5, P6, P7, P8>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc9(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass10<T, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9>(selector rawSelector: String, initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> T) throws -> AnyTypeDelegate<T> {
        try defineGlobalFunc10(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    private func continueDefiningClass<T>(_ type: T.Type) -> AnyTypeDelegate<T> {
        let delegate = DefaultTypeDelegate<T>()
        typeDelegates.registerTypeDelegate(delegate)
        return .init(delegate)
    }
}
