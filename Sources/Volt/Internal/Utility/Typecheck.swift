func typecheck<T0, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ block: (T0) throws -> R) throws -> R {
    guard args.count == 1 else {
        throw InternalError.invalidNumberOfArguments(expected: 1, got: args.count)
    }

    if let convertible = T0.self as? ReverseValueConvertible.Type,
       let v0 = convertible.fromVoltValue(args[0]) as? T0 {
           return try block(v0)
    }

    guard let v0 = args[0].any as? T0 else {
        throw InternalError.typeError(expected: String(describing: T0.self), got: args[0].typeName)
    }

    return try block(v0)
}

func typecheck<T0, T1, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ block: (T0, T1) throws -> R) throws -> R {
    guard args.count == 2 else {
        throw InternalError.invalidNumberOfArguments(expected: 2, got: args.count)
    }

    return try typecheck([args[0]], type0, { a0 in
        try typecheck([args[1]], type1) { a1 in
            try block(a0, a1)
        }
    })
}

func typecheck<T0, T1, T2, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ block: (T0, T1, T2) throws -> R) throws -> R {
    guard args.count == 3 else {
        throw InternalError.invalidNumberOfArguments(expected: 3, got: args.count)
    }

    return try typecheck([args[0], args[1]], type0, type1, { a0, a1 in
        try typecheck([args[2]], type2) { a2 in
            try block(a0, a1, a2)
        }
    })
}

func typecheck<T0, T1, T2, T3, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ block: (T0, T1, T2, T3) throws -> R) throws -> R {
    guard args.count == 4 else {
        throw InternalError.invalidNumberOfArguments(expected: 4, got: args.count)
    }

    return try typecheck([args[0], args[1], args[2]], type0, type1, type2, { a0, a1, a2 in
        try typecheck([args[3]], type3) { a3 in
            try block(a0, a1, a2, a3)
        }
    })
}
