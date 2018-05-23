public protocol TypeDelegate {
    associatedtype Object
    typealias Getter = (_ object: Object) -> Value
    typealias Setter = (_ object: Object, _ value: Value) -> Void

    func getterForProperty(named name: String) -> Getter?
    func setterForProperty(named name: String) -> Setter?

    func registerProperty(named name: String, getter: @escaping Getter, setter: Setter?)

    func unregisterProperty(named name: String)
    func unregisterAllProperties()
}
