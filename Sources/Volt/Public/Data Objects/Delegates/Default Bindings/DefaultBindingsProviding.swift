public protocol DefaultBindingsProviding {
    static func registerDefaultBindings<Delegate: BuiltinDelegate>(using delegate: Delegate)
        where Delegate.Object == Self
}
