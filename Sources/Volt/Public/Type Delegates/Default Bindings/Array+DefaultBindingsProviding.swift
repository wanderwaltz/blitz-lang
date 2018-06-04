extension TypeDelegatesRepository {
    func registerDefaultArrayBindings() {
        registerTypeDelegate(DefaultTypeDelegate<[Value]>(), forKey: "Array")
            .registerProperty(named: "isEmpty", keyPath: \.isEmpty)
            .registerProperty(named: "count", keyPath: \.count)

            .registerProperty(named: "first", keyPath: \.first)
            .registerProperty(named: "last", keyPath: \.last)

            .registerMethod(selector: "appending(_:)", method: { array in { (value: Any) -> [Value] in
                var result = array
                result.append(.init(value))
                return result
            }})

            .registerMethod(selector: "inserting(_:at:)", method: { array in { (value: Any, index: Int) -> [Value] in
                guard array.indices ~= index else {
                    throw RuntimeError(
                        code: .arrayIndexOutOfBounds,
                        message: "index \(index) is out of bounds: \(array.indices)"
                    )
                }

                var result = array
                result.insert(.init(value), at: index)
                return result
            }})

            .registerMethod(selector: "removing(at:)", method: { array in { (index: Int) -> [Value] in
                guard array.indices ~= index else {
                    throw RuntimeError(
                        code: .arrayIndexOutOfBounds,
                        message: "index \(index) is out of bounds: \(array.indices)"
                    )
                }

                var result = array
                result.remove(at: index)
                return result
            }})
    }
}
