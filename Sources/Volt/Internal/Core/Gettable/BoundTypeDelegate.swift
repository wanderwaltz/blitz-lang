struct BoundTypeDelegate<Delegate: TypeDelegate> {
    typealias Object = Delegate.Object

    init(object: Object, delegate: Delegate) {
        self.object = object
        self.delegate = delegate
    }

    private let object: Object
    private let delegate: Delegate
}


extension BoundTypeDelegate: Gettable {
    func getProperty(named name: String) throws -> Value {
        guard let getter = delegate.getterForProperty(named: name) else {
            throw InternalError.unknownProperty(named: name)
        }

        return getter(object)
    }
}


extension TypeDelegate {
    func bind(_ object: Object) -> BoundTypeDelegate<Self> {
        return .init(object: object, delegate: self)
    }
}
