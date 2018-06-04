import Foundation

public final class TypeDelegatesRepository {
    private var delegates: [String: BindableDelegate] = [:]
}


extension TypeDelegatesRepository {
    public func withDelegate<T>(
        for type: T.Type,
        key: String = String(describing: T.self),
        do block: (AnyTypeDelegate<T>) -> Void
    ) {
        let existingDelegate = delegates[key]?.rawValue as? AnyTypeDelegate<T>
        let delegate = existingDelegate ?? AnyTypeDelegate(DefaultTypeDelegate())

        if existingDelegate == nil {
            delegates[key] = BindableDelegate(delegate)
        }

        block(delegate)
    }

    @discardableResult
    public func registerTypeDelegate<Delegate: TypeDelegate>
        (_ delegate: Delegate, forKey key: String = String(describing: Delegate.Object.self))
            -> AnyTypeDelegate<Delegate.Object> {
                let anyDelegate = AnyTypeDelegate(delegate)
                delegates[key] = BindableDelegate(anyDelegate)
                return anyDelegate
    }

    public func registerDefaultBindings<T: DefaultBindingsProviding>(for type: T.Type) {
        withDelegate(for: type, do: { type.registerDefaultBindings(using: $0) })
    }
}


extension TypeDelegatesRepository {
    func gettable(for value: Value) -> Gettable? {
        let key = value.typeName
        return delegates[key]?.bind(value)
    }

    func settable(for value: Value) -> Settable? {
        let key = value.typeName
        return delegates[key]?.bind(value)
    }
}


private struct BindableDelegate {
    let rawValue: Any

    init<Delegate: TypeDelegate>(_ delegate: Delegate) {
        rawValue = delegate
        _bind = { value in
            guard let value = value as? Delegate.Object else {
                return nil
            }

            return delegate.bind(value)
        }
    }

    private let _bind: (Any?) -> (Gettable & Settable)?
}


extension BindableDelegate {
    func bind(_ value: Value) -> (Gettable & Settable)? {
        return _bind(value.any)
    }
}
