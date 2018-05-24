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

func typecheck<T0, T1, T2, T3, T4, T5, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ type4: T4.Type,
               _ type5: T5.Type,
               _ block: (T0, T1, T2, T3, T4, T5) throws -> R) throws -> R {
    guard args.count == 6 else {
        throw InternalError.invalidNumberOfArguments(expected: 6, got: args.count)
    }

    let subargs = [args[0], args[1], args[2], args[3], args[4]]

    return try typecheck(subargs, type0, type1, type2, type3, type4, { a0, a1, a2, a3, a4 in
        try typecheck(args[5], type5) { a5 in
            try block(a0, a1, a2, a3, a4, a5)
        }
    })
}

func typecheck<T0, T1, T2, T3, T4, T5, T6, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ type4: T4.Type,
               _ type5: T5.Type,
               _ type6: T6.Type,
               _ block: (T0, T1, T2, T3, T4, T5, T6) throws -> R) throws -> R {
    guard args.count == 7 else {
        throw InternalError.invalidNumberOfArguments(expected: 7, got: args.count)
    }

    let subargs = [args[0], args[1], args[2], args[3], args[4], args[5]]

    return try typecheck(subargs, type0, type1, type2, type3, type4, type5, { a0, a1, a2, a3, a4, a5 in
        try typecheck(args[6], type6) { a6 in
            try block(a0, a1, a2, a3, a4, a5, a6)
        }
    })
}

func typecheck<T0, T1, T2, T3, T4, T5, T6, T7, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ type4: T4.Type,
               _ type5: T5.Type,
               _ type6: T6.Type,
               _ type7: T7.Type,
               _ block: (T0, T1, T2, T3, T4, T5, T6, T7) throws -> R) throws -> R {
    guard args.count == 8 else {
        throw InternalError.invalidNumberOfArguments(expected: 8, got: args.count)
    }

    let subargs = [args[0], args[1], args[2], args[3], args[4], args[5], args[6]]

    return try typecheck(subargs, type0, type1, type2, type3, type4, type5, type6, { a0, a1, a2, a3, a4, a5, a6 in
        try typecheck(args[7], type7) { a7 in
            try block(a0, a1, a2, a3, a4, a5, a6, a7)
        }
    })
}

func typecheck<T0, T1, T2, T3, T4, T5, T6, T7, T8, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ type4: T4.Type,
               _ type5: T5.Type,
               _ type6: T6.Type,
               _ type7: T7.Type,
               _ type8: T8.Type,
               _ block: (T0, T1, T2, T3, T4, T5, T6, T7, T8) throws -> R) throws -> R {
    guard args.count == 9 else {
        throw InternalError.invalidNumberOfArguments(expected: 9, got: args.count)
    }

    let subargs = [args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]]

    return try typecheck(subargs, type0, type1, type2, type3, type4, type5, type6, type7, { a0, a1, a2, a3, a4, a5, a6, a7 in
        try typecheck(args[8], type8) { a8 in
            try block(a0, a1, a2, a3, a4, a5, a6, a7, a8)
        }
    })
}

func typecheck<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, R>
              (_ args: [Value],
               _ type0: T0.Type,
               _ type1: T1.Type,
               _ type2: T2.Type,
               _ type3: T3.Type,
               _ type4: T4.Type,
               _ type5: T5.Type,
               _ type6: T6.Type,
               _ type7: T7.Type,
               _ type8: T8.Type,
               _ type9: T9.Type,
               _ block: (T0, T1, T2, T3, T4, T5, T6, T7, T8, T9) throws -> R) throws -> R {
    guard args.count == 10 else {
        throw InternalError.invalidNumberOfArguments(expected: 10, got: args.count)
    }

    let subargs = [args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]]

    return try typecheck(subargs, type0, type1, type2, type3, type4, type5, type6, type7, type8, { a0, a1, a2, a3, a4, a5, a6, a7, a8 in
        try typecheck(args[9], type9) { a9 in
            try block(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9)
        }
    })
}
