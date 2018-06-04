// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension TypeDelegate {
    @discardableResult
    public func registerMethod<R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> () throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, _ in
                        .init(try method())
                    })
                    .checkingArity(0)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self) {
                            Value(try method($0))
                        }
                    })
                    .checkingArity(1)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self) {
                            Value(try method($0, $1))
                        }
                    })
                    .checkingArity(2)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self) {
                            Value(try method($0, $1, $2))
                        }
                    })
                    .checkingArity(3)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self) {
                            Value(try method($0, $1, $2, $3))
                        }
                    })
                    .checkingArity(4)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3, T4) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self) {
                            Value(try method($0, $1, $2, $3, $4))
                        }
                    })
                    .checkingArity(5)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self) {
                            Value(try method($0, $1, $2, $3, $4, $5))
                        }
                    })
                    .checkingArity(6)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self) {
                            Value(try method($0, $1, $2, $3, $4, $5, $6))
                        }
                    })
                    .checkingArity(7)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, T7, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6, T7) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self, T7.self) {
                            Value(try method($0, $1, $2, $3, $4, $5, $6, $7))
                        }
                    })
                    .checkingArity(8)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, T7, T8, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6, T7, T8) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self, T7.self, T8.self) {
                            Value(try method($0, $1, $2, $3, $4, $5, $6, $7, $8))
                        }
                    })
                    .checkingArity(9)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, R>
                              (selector rawSelector: String,
                               method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6, T7, T8, T9) throws -> R) -> Self {
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

        return registerProperty(
            named: selector.name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self, T7.self, T8.self, T9.self) {
                            Value(try method($0, $1, $2, $3, $4, $5, $6, $7, $8, $9))
                        }
                    })
                    .checkingArity(10)
                    .checkingSignature(selector.signature)
                )
            },
            setter: nil
        )
    }

}
