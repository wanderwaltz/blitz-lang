protocol TypeInfo: Gettable, CustomStringConvertible, CustomRuntimeTypeNameProviding {
    associatedtype InstanceType

    typealias ComputedProperty = Volt.ComputedProperty<InstanceType>
    typealias Method = Volt.Method<InstanceType>

    var name: String { get }
    var supertype: Self? { get }

    var storedProperties: [String: StoredProperty] { get }
    var computedProperties: [String: ComputedProperty] { get }
    var methods: [String: Method] { get }

    func enumerateStoredProperties(with block: (StoredProperty) -> Void)
    func lookupStoredProperty(named name: String) -> StoredProperty?
    func lookupComputedProperty(named name: String) -> ComputedProperty?

    func lookupMethod(named name: String) -> Method?
}
