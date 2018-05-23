public final class DefaultTypeDelegate<T> {
    private(set) var getters: [String: Getter] = [:]
    private(set) var setters: [String: Setter] = [:]
}


extension DefaultTypeDelegate: TypeDelegate {
    public typealias Object = T

    public func getterForProperty(named name: String) -> Getter? {
        return getters[name]
    }

    public func setterForProperty(named name: String) -> Setter? {
        return setters[name]
    }

    public func registerProperty(named name: String, getter: @escaping Getter, setter: Setter?) {
        getters[name] = getter

        if let setter = setter {
            setters[name] = setter
        }
        else {
            setters.removeValue(forKey: name)
        }
    }

    public func unregisterProperty(named name: String) {
        getters.removeValue(forKey: name)
        setters.removeValue(forKey: name)
    }

    public func unregisterAllProperties() {
        getters = [:]
        setters = [:]
    }
}
