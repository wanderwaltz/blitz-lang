protocol TypeInfo: Gettable, CustomStringConvertible, CustomRuntimeTypeNameProviding {
    associatedtype InstanceType

    typealias ComputedProperty = Blitz.ComputedProperty<InstanceType>
    typealias Method = Blitz.Method<InstanceType>

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
