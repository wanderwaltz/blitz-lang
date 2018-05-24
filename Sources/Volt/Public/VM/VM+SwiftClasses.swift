// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension VM {
    public func defineClass0<T>(initializer: @escaping () -> T,
                                with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc0(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass1<T, P0>(initializer: @escaping (P0) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc1(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass2<T, P0, P1>(initializer: @escaping (P0, P1) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc2(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass3<T, P0, P1, P2>(initializer: @escaping (P0, P1, P2) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc3(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass4<T, P0, P1, P2, P3>(initializer: @escaping (P0, P1, P2, P3) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc4(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass5<T, P0, P1, P2, P3, P4>(initializer: @escaping (P0, P1, P2, P3, P4) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc5(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass6<T, P0, P1, P2, P3, P4, P5>(initializer: @escaping (P0, P1, P2, P3, P4, P5) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc6(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass7<T, P0, P1, P2, P3, P4, P5, P6>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc7(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass8<T, P0, P1, P2, P3, P4, P5, P6, P7>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc8(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass9<T, P0, P1, P2, P3, P4, P5, P6, P7, P8>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc9(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    public func defineClass10<T, P0, P1, P2, P3, P4, P5, P6, P7, P8, P9>(initializer: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> T, with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc10(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    private func continueDefiningClass<T>(with block: (AnyTypeDelegate<T>) -> Void) {
        typeDelegates.withDelegate(for: T.self, do: block)
    }
}
