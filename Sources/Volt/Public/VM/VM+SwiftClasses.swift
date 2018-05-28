// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension VM {
    @discardableResult
    public func defineClass0<T>(selector rawSelector: String = "\(String(describing: T.self))()", initializer: @escaping () -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc0(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass1<T, P0>(selector rawSelector: String = "\(String(describing: T.self))(_:)", initializer: @escaping (P0) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc1(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass2<T, P0, P1>(selector rawSelector: String = "\(String(describing: T.self))(_:_:)", initializer: @escaping (P0, P1) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc2(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass3<T, P0, P1, P2>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:)", initializer: @escaping (P0, P1, P2) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc3(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass4<T, P0, P1, P2, P3>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc4(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass5<T, P0, P1, P2, P3, P4>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3, P4) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc5(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass6<T, P0, P1, P2, P3, P4, P5>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3, P4, P5) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc6(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass7<T, P0, P1, P2, P3, P4, P5, P6>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3, P4, P5, P6) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc7(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass8<T, P0, P1, P2, P3, P4, P5, P6, P7>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc8(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass9<T, P0, P1, P2, P3, P4, P5, P6, P7, P8>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc9(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    @discardableResult
    public func defineClass10<T, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9>(selector rawSelector: String = "\(String(describing: T.self))(_:_:_:_:_:_:_:_:_:_:)", initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> T) -> AnyTypeDelegate<T> {
        defineGlobalFunc10(selector: rawSelector, func: initializer)
        return continueDefiningClass(T.self)
    }

    private func continueDefiningClass<T>(_ type: T.Type) -> AnyTypeDelegate<T> {
        let delegate = DefaultTypeDelegate<T>()
        typeDelegates.registerTypeDelegate(delegate)
        return .init(delegate)
    }
}
