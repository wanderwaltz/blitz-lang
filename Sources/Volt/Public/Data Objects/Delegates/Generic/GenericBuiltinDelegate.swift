public final class GenericBuiltinDelegate<T: DefaultBindingsProviding> {
    public typealias Getter = (T) -> Value

    init() {
        T.registerDefaultBindings(using: self)
    }

    private(set) var getters: [String: Getter] = [:]
}


extension GenericBuiltinDelegate: BuiltinDelegate {
    public typealias Object = T

    public func registerProperty(named name: String, getter: @escaping (_ object: T) -> Value) {
        getters[name] = getter
    }

    public func unregisterProperty(named name: String) {
        getters.removeValue(forKey: name)
    }

    public func unregisterAllProperties() {
        getters = [:]
    }
}
