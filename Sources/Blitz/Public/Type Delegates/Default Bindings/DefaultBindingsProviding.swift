public protocol DefaultBindingsProviding {
    static func registerDefaultBindings<Delegate: TypeDelegate>(using delegate: Delegate)
        where Delegate.Object == Self
}
