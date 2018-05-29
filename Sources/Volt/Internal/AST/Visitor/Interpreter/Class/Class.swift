struct Class {
    let name: String
    let initializer: Function
    let storedProperties: [String: StoredProperty]
    let computedProperties: [String: ComputedProperty]
    let methods: [String: Function]
}


extension Class {
    var arity: Int {
        return initializer.arity
    }
}
