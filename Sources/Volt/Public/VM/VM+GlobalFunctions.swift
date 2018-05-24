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
