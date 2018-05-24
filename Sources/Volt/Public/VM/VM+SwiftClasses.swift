extension VM {
    public func defineClass0<T>(initializer: @escaping () -> T,
                                with block: (AnyTypeDelegate<T>) -> Void) throws {
        try defineGlobalFunc0(named: String(describing: T.self), func: initializer)
        continueDefiningClass(with: block)
    }

    private func continueDefiningClass<T>(with block: (AnyTypeDelegate<T>) -> Void) {
        typeDelegates.withDelegate(for: T.self, do: block)
    }
}
