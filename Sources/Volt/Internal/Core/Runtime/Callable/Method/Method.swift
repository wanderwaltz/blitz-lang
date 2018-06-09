struct Method<_InstanceType> {
    typealias InstanceType = _InstanceType

    init(_ bind: @escaping (InstanceType) throws -> Callable) {
        _bind = bind
    }

    private let _bind: (InstanceType) throws -> Callable
}


extension Method {
    func bind(to instance: InstanceType) throws -> Callable {
        return try _bind(instance)
    }
}
