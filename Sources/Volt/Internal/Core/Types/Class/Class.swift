final class Class {
    typealias Instantiator = Volt.Instantiator<Instance>
    typealias Method = Volt.Method<Instance>
    typealias ComputedProperty = Volt.ComputedProperty<Instance>

    let name: String
    let superclass: Class?
    let instantiator: Instantiator
    let storedProperties: [String: StoredProperty]
    let computedProperties: [String: ComputedProperty]
    let methods: [String: Method]

    init(name: String,
         superclass: Class?,
         instantiator: Instantiator,
         storedProperties: [String: StoredProperty],
         computedProperties: [String: ComputedProperty],
         methods: [String: Method]) {
             self.name = name
             self.superclass = superclass
             self.instantiator = instantiator
             self.storedProperties = storedProperties
             self.computedProperties = computedProperties
             self.methods = methods
    }
}
