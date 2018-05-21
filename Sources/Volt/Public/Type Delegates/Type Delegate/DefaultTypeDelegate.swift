public final class DefaultTypeDelegate<T> {
    private(set) var getters: [String: Getter] = [:]
}


extension DefaultTypeDelegate: TypeDelegate {
    public typealias Object = T

    public func getterForProperty(named name: String) -> Getter? {
        return getters[name]
    }

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
