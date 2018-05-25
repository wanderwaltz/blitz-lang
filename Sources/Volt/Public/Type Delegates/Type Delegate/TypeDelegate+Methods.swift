// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension TypeDelegate {
    @discardableResult
    public func registerMethod<R>(named name: String, method getter: @escaping (Object) -> () -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, _ in
                        .init(method())
                    })
                    .checkingArity(0)
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, R>(named name: String, method getter: @escaping (Object) -> (T0) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self) {
                            Value(method($0))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, R>(named name: String, method getter: @escaping (Object) -> (T0, T1) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self) {
                            Value(method($0, $1))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self) {
                            Value(method($0, $1, $2))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self) {
                            Value(method($0, $1, $2, $3))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3, T4) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self) {
                            Value(method($0, $1, $2, $3, $4))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self) {
                            Value(method($0, $1, $2, $3, $4, $5))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self) {
                            Value(method($0, $1, $2, $3, $4, $5, $6))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, T7, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6, T7) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self, T7.self) {
                            Value(method($0, $1, $2, $3, $4, $5, $6, $7))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, T7, T8, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6, T7, T8) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self, T7.self, T8.self) {
                            Value(method($0, $1, $2, $3, $4, $5, $6, $7, $8))
                        }
                    })
                )
            },
            setter: nil
        )
    }

    @discardableResult
    public func registerMethod<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, R>(named name: String, method getter: @escaping (Object) -> (T0, T1, T2, T3, T4, T5, T6, T7, T8, T9) -> R) -> Self {
        return registerProperty(
            named: name,
            getter: { object in
                let method = getter(object)

                return .object(
                    AnyCallable({ _, _, args in
                        return try typecheck(args, T0.self, T1.self, T2.self, T3.self, T4.self, T5.self, T6.self, T7.self, T8.self, T9.self) {
                            Value(method($0, $1, $2, $3, $4, $5, $6, $7, $8, $9))
                        }
                    })
                )
            },
            setter: nil
        )
    }

}
