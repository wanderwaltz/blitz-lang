// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension VM {
    public func defineGlobalFunc0<R>(selector rawSelector: String, `func`: @escaping () -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 0 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 0 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, _ in
                .init(`func`())
            })
            .checkingArity(0)
        )
    }

    public func defineGlobalFunc1<P0, R>(selector rawSelector: String, `func`: @escaping (P0) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 1 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 1 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self) {
                    .init(`func`($0))
                }
            })
            .checkingArity(1)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc2<P0, P1, R>(selector rawSelector: String, `func`: @escaping (P0, P1) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 2 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 2 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self) {
                    .init(`func`($0, $1))
                }
            })
            .checkingArity(2)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc3<P0, P1, P2, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 3 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 3 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self) {
                    .init(`func`($0, $1, $2))
                }
            })
            .checkingArity(3)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc4<P0, P1, P2, P3, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 4 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 4 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self) {
                    .init(`func`($0, $1, $2, $3))
                }
            })
            .checkingArity(4)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc5<P0, P1, P2, P3, P4, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3, P4) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 5 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 5 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self) {
                    .init(`func`($0, $1, $2, $3, $4))
                }
            })
            .checkingArity(5)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc6<P0, P1, P2, P3, P4, P5, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3, P4, P5) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 6 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 6 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5))
                }
            })
            .checkingArity(6)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc7<P0, P1, P2, P3, P4, P5, P6, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 7 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 7 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6))
                }
            })
            .checkingArity(7)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc8<P0, P1, P2, P3, P4, P5, P6, P7, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6, P7) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 8 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 8 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self, P7.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6, $7))
                }
            })
            .checkingArity(8)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc9<P0, P1, P2, P3, P4, P5, P6, P7, P8, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 9 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 9 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self, P7.self, P8.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6, $7, $8))
                }
            })
            .checkingArity(9)
            .checkingSignature(selector.signature)
        )
    }

    public func defineGlobalFunc10<P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, R>(selector rawSelector: String, `func`: @escaping (P0, P1, P2, P3, P4, P5, P6, P7, P8, P9) -> R) {
        guard let selector = Selector(rawValue: rawSelector) else {
            preconditionFailure("invalid selector: '\(rawSelector)'")
        }

        let selectorArgumentsCount = selector.signature.components.count

        guard selectorArgumentsCount == 10 else {
            preconditionFailure(
                """
                invalid number of arguments: expected 10 arguments in selector '\(selector)', got: \(selectorArgumentsCount)
                """
            )
        }

        defineGlobal(
            named: selector.name,
            value: AnyCallable({ _, _, args in
                return try typecheck(args, P0.self, P1.self, P2.self, P3.self, P4.self, P5.self, P6.self, P7.self, P8.self, P9.self) {
                    .init(`func`($0, $1, $2, $3, $4, $5, $6, $7, $8, $9))
                }
            })
            .checkingArity(10)
            .checkingSignature(selector.signature)
        )
    }

}
