protocol Gettable {
    func getProperty(named name: String) throws -> Value
}
