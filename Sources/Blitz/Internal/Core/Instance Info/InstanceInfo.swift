/// Common properties for an instance of a certain type
protocol InstanceInfo: Gettable, Settable, CustomRuntimeTypeNameProviding, BlitzStringConvertible {
    associatedtype Klass: TypeInfo where Klass.InstanceType == Self

    var klass: Klass { get }

    /// Support `super` property lookup in instances of inherited classes
    func getProperty(named name: String,
                     inClass lookupClass: Klass,
                     interpreter: Interpreter) throws -> Value

    /// Support setting properties of `super` in instances of inherited classes
    func setProperty(named name: String,
                     value: Value,
                     inClass lookupClass: Klass,
                     interpreter: Interpreter) throws

    func lookupStoredProperty(named name: String) -> Value?
    func setStoredProperty(named name: String, newValue: Value) throws
}
