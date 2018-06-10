final class Class: TypeInfo, Instantiatable {
    typealias InstanceType = Instance
    typealias Instantiator = Volt.Instantiator<Class>
    typealias ComputedProperty = Volt.ComputedProperty<InstanceType>
    typealias Method = Volt.Method<InstanceType>

    let name: String
    let supertype: Class?
    let instantiator: Instantiator
    let storedProperties: [String: StoredProperty]
    let computedProperties: [String: ComputedProperty]
    let methods: [String: Method]

    init(name: String,
         supertype: Class?,
         instantiator: Instantiator,
         storedProperties: [String: StoredProperty],
         computedProperties: [String: ComputedProperty],
         methods: [String: Method]) {
             self.name = name
             self.supertype = supertype
             self.instantiator = instantiator
             self.storedProperties = storedProperties
             self.computedProperties = computedProperties
             self.methods = methods
    }
}
