public struct AnyTypeDelegate<T> {
    init<Delegate: TypeDelegate>(_ delegate: Delegate) where Delegate.Object == Object {
        _getter = delegate.getterForProperty
        _setter = delegate.setterForProperty
        _register = { delegate.registerProperty(named: $0, getter: $1, setter: $2) }
        _unregister = delegate.unregisterProperty
        _unregisterAll = delegate.unregisterAllProperties
    }

    private let _getter: (String) -> Getter?
    private let _setter: (String) -> Setter?
    private let _register: (String, @escaping Getter, Setter?) -> Void
    private let _unregister: (String) -> Void
    private let _unregisterAll: () -> Void
}


extension AnyTypeDelegate: TypeDelegate {
    public typealias Object = T

    public func getterForProperty(named name: String) -> Getter? {
        return _getter(name)
    }

    public func setterForProperty(named name: String) -> Setter? {
        return _setter(name)
    }

    @discardableResult
    public func registerProperty(named name: String, getter: @escaping Getter, setter: Setter?) -> AnyTypeDelegate {
        _register(name, getter, setter)
        return self
    }

    public func unregisterProperty(named name: String) {
        _unregister(name)
    }

    public func unregisterAllProperties() {
        _unregisterAll()
    }
}
