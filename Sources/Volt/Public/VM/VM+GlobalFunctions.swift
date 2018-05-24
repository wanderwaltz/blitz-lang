// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


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

    public func defineGlobalFunc3<P0, P1, P2, R>(named name: String, `func`: @escaping (P0, P1, P2) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self) {
                    .init(`func`($0, $1, $2))
                }
            })
        )
    }

    public func defineGlobalFunc4<P0, P1, P2, P3, R>(named name: String, `func`: @escaping (P0, P1, P2, P3) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self) {
                    .init(`func`($0, $1, $2, $3))
                }
            })
        )
    }

    public func defineGlobalFunc5<P0, P1, P2, P3, P4, R>(named name: String, `func`: @escaping (P0, P1, P2, P3, P4) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self) {
                    .init(`func`($0, $1, $2, $3, $4))
                }
            })
        )
    }

    public func defineGlobalFunc6<P0, P1, P2, P3, P4, P5, R>(named name: String, `func`: @escaping (P0, P1, P2, P3, P4, P5) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5))
                }
            })
        )
    }

    public func defineGlobalFunc7<P0, P1, P2, P3, P4, P5, P6, R>(named name: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6))
                }
            })
        )
    }

    public func defineGlobalFunc8<P0, P1, P2, P3, P4, P5, P6, P7, R>(named name: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self, P7.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6, $7))
                }
            })
        )
    }

    public func defineGlobalFunc9<P0, P1, P2, P3, P4, P5, P6, P7, P8, R>(named name: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self, P7.self, P8.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6, $7, $8))
                }
            })
        )
    }

    public func defineGlobalFunc10<P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, R>(named name: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> R) throws {
        try defineGlobal(
            named: name,
            value: AnyCallable({ _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self, P7.self, P8.self, P9.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6, $7, $8, $9))
                }
            })
        )
    }

}
