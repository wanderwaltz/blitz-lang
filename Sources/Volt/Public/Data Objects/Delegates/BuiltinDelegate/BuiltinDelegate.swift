public protocol BuiltinDelegate {
    associatedtype Object

    func registerProperty(named name: String, getter: @escaping (_ object: Object) -> Value)
    func unregisterProperty(named name: String)
    func unregisterAllProperties()
}
