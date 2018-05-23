import Foundation

extension VM {
    public func defineGlobalFunc0<R>(named name: String, `func`: @escaping () -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, _ in
                .init(`func`())
            })
            .checkingArity(0)
        )
    }

    public func defineGlobalFunc1<P0, R>(named name: String, `func`: @escaping (P0) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self) {
                    .init(`func`($0))
                }
            })
        )
    }

    public func defineGlobalFunc2<P0, P1, R>(named name: String, `func`: @escaping (P0, P1) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self) {
                    .init(`func`($0, $1))
                }
            })
        )
    }

    public func defineGlobalFunc3<P0, P1, P2, R>
                                 (named name: String,
                                  `func`: @escaping (P0, P1, P2) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self) {
                    .init(`func`($0, $1, $2))
                }
            })
        )
    }

    public func defineGlobalFunc4<P0, P1, P2, P3, R>
                                 (named name: String,
                                  `func`: @escaping (P0, P1, P2, P3) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self) {
                    .init(`func`($0, $1, $2, $3))
                }
            })
        )
    }
}


/// Swift classes interaction
extension VM {
    public func defineClass0<T>(initializer: @escaping () -> T,
                               with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc0(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    private func continueDefiningClass<T>(with block: (AnyTypeDelegate<T>) -> Void) {
        typeDelegates.withDelegate(for: T.self, do: block)
    }
}


/// NSObject interaction
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
