public struct AnyTypeDelegate<T> {
    init<Delegate: TypeDelegate>(_ delegate: Delegate) where Delegate.Object == Object {
        _getter = delegate.getterForProperty
        _register = delegate.registerProperty
        _unregister = delegate.unregisterProperty
        _unregisterAll = delegate.unregisterAllProperties
    }

    private let _getter: (String) -> Getter?
    private let _register: (String, @escaping Getter) -> Void
    private let _unregister: (String) -> Void
    private let _unregisterAll: () -> Void
}


extension AnyTypeDelegate: TypeDelegate {
    public typealias Object = T

    public func getterForProperty(named name: String) -> Getter? {
        return _getter(name)
    }

    public func registerProperty(named name: String, getter: @escaping Getter) {
        _register(name, getter)
    }

    public func unregisterProperty(named name: String) {
        _unregister(name)
    }

    public func unregisterAllProperties() {
        _unregisterAll()
    }
}
