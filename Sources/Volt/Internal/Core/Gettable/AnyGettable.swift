struct AnyGettable {
    init(_ _get: @escaping (String) throws -> Value) {
        self._get = _get
    }

    private let _get: (String) throws -> Value
}


extension AnyGettable: Gettable {
    func getProperty(named name: String) throws -> Value {
        return try _get(name)
    }
}
