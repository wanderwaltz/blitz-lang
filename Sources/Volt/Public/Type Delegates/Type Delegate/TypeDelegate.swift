public protocol TypeDelegate {
    associatedtype Object
    typealias Getter = (_ object: Object) throws -> Value
    typealias Setter = (_ object: Object, _ value: Value) throws -> Void

    func getterForProperty(named name: String) -> Getter?
    func setterForProperty(named name: String) -> Setter?

    @discardableResult
    func registerProperty(named name: String, getter: @escaping Getter, setter: Setter?) -> Self

    func unregisterProperty(named name: String)
    func unregisterAllProperties()
}
