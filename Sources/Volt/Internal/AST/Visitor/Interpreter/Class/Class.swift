struct Class {
    let name: String
    let methods: [String: Function]
    let initializer: Function
}


extension Class {
    var arity: Int {
        return initializer.arity
    }
}
