public protocol TypeDelegate {
    associatedtype Object
    typealias Getter = (_ object: Object) -> Value

    func getterForProperty(named name: String) -> Getter?

    func registerProperty(named name: String, getter: @escaping Getter)

    func unregisterProperty(named name: String)
    func unregisterAllProperties()
}
