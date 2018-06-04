final class Class {
    let name: String
    let superclass: Class?
    let initializer: Function
    let storedProperties: [String: StoredProperty]
    let computedProperties: [String: ComputedProperty]
    let methods: [String: Function]

    init(name: String,
         superclass: Class?,
         initializer: Function,
         storedProperties: [String: StoredProperty],
         computedProperties: [String: ComputedProperty],
         methods: [String: Function]) {
             self.name = name
             self.superclass = superclass
             self.initializer = initializer
             self.storedProperties = storedProperties
             self.computedProperties = computedProperties
             self.methods = methods
    }
}


extension Class {
    var arity: Int {
        return initializer.arity
    }
}
