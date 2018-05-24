// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


/// Type-checking a single value
func typecheck<T, R>(_ value: Value, _ type: T.Type, _ block: (T) throws -> R) throws -> R {
    if let convertible = T.self as? ReverseValueConvertible.Type,
       let v = convertible.fromVoltValue(value) as? T {
           return try block(v)
    }

    guard let v = value.any as? T else {
        throw InternalError.typeError(expected: String(describing: T.self), got: value.typeName)
    }

    return try block(v)
}

func typecheck<T0, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ block: (T0) throws -> R) throws -> R {
    guard args.count == 1 else {
        throw InternalError.invalidNumberOfArguments(expected: 1, got: args.count)
    }

    return try typecheck(args[0], type0, block)
}

func typecheck<T0, T1, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ block: (T0, T1) throws -> R) throws -> R {
    guard args.count == 2 else {
        throw InternalError.invalidNumberOfArguments(expected: 2, got: args.count)
    }

    let subargs = [args[0]]

    return try typecheck(subargs, type0, { a0 in
        try typecheck(args[1], type1) { a1 in
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

    let subargs = [args[0], args[1]]

    return try typecheck(subargs, type0, type1, { a0, a1 in
        try typecheck(args[2], type2) { a2 in
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

    let subargs = [args[0], args[1], args[2]]

    return try typecheck(subargs, type0, type1, type2, { a0, a1, a2 in
        try typecheck(args[3], type3) { a3 in
            try block(a0, a1, a2, a3)
        }
    })
}

func typecheck<T0, T1, T2, T3, T4, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ type4: T4.Type,
               _ block: (T0, T1, T2, T3, T4) throws -> R) throws -> R {
    guard args.count == 5 else {
        throw InternalError.invalidNumberOfArguments(expected: 5, got: args.count)
    }

    let subargs = [args[0], args[1], args[2], args[3]]

    return try typecheck(subargs, type0, type1, type2, type3, { a0, a1, a2, a3 in
        try typecheck(args[4], type4) { a4 in
            try block(a0, a1, a2, a3, a4)
        }
    })
}

