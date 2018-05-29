struct Class {
    let name: String
    let initializer: Function
    let storedProperties: [String: StoredProperty]
    let readonlyComputedProperties: [String: ReadonlyComputedProperty]
    let methods: [String: Function]
}


extension Class {
    var arity: Int {
        return initializer.arity
    }
}
