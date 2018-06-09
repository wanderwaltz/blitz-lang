final class Class {
    typealias Method = Volt.Method<Instance>
    typealias ComputedProperty = Volt.ComputedProperty<Instance>

    let name: String
    let superclass: Class?
    let initializer: Method
    let storedProperties: [String: StoredProperty]
    let computedProperties: [String: ComputedProperty]
    let methods: [String: Method]

    init(name: String,
         superclass: Class?,
         initializer: Method,
         storedProperties: [String: StoredProperty],
         computedProperties: [String: ComputedProperty],
         methods: [String: Method]) {
             self.name = name
             self.superclass = superclass
             self.initializer = initializer
             self.storedProperties = storedProperties
             self.computedProperties = computedProperties
             self.methods = methods
    }
}
