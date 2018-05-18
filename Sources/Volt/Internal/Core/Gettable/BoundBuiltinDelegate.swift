struct BoundBuiltinDelegate<Delegate: BuiltinDelegate> {
    typealias Object = Delegate.Object

    init(object: Object, delegate: Delegate) {
        self.object = object
        self.delegate = delegate
    }

    private let object: Object
    private let delegate: Delegate
}


extension BoundBuiltinDelegate: Gettable {
    func getProperty(named name: String) throws -> Value {
        guard let getter = delegate.getterForProperty(named: name) else {
            throw InternalError.unknownProperty(named: name)
        }

        return getter(object)
    }
}


extension BuiltinDelegate {
    func bind(_ object: Object) -> BoundBuiltinDelegate<Self> {
        return BoundBuiltinDelegate(object: object, delegate: self)
    }
}
