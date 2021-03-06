struct BoundTypeDelegate<Delegate: TypeDelegate> {
    typealias Object = Delegate.Object

    init(object: Object, delegate: Delegate) {
        self.object = object
        self.delegate = delegate
    }

    private let object: Object
    private let delegate: Delegate
}


extension BoundTypeDelegate: Gettable, Settable {
    func getProperty(named name: String, interpreter: Interpreter) throws -> Value {
        guard let getter = delegate.getterForProperty(named: name) else {
            throw RuntimeError.unknownProperty(named: name)
        }

        return try getter(object)
    }

    func setProperty(named name: String, value: Value, interpreter: Interpreter) throws {
        guard let setter = delegate.setterForProperty(named: name) else {
            if delegate.getterForProperty(named: name) != nil {
                throw RuntimeError.settingReadonlyProperty(named: name)
            }
            else {
                throw RuntimeError.unknownProperty(named: name)
            }
        }

        try setter(object, value)
    }
}


extension TypeDelegate {
    func bind(_ object: Object) -> BoundTypeDelegate<Self> {
        return .init(object: object, delegate: self)
    }
}
