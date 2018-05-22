import Foundation

public final class NSObjectTypeDelegate<T: NSObject> {
    private(set) var getters: [String: Getter] = [:]
}


extension NSObjectTypeDelegate: TypeDelegate {
    public typealias Object = T

    public func getterForProperty(named name: String) -> Getter? {
        return getters[name] ?? defaultGetterForProperty(named: name)
    }

    public func registerProperty(named name: String, getter: @escaping (_ object: T) -> Value) {
        getters[name] = getter
    }

    public func unregisterProperty(named name: String) {
        getters.removeValue(forKey: name)
    }

    public func unregisterAllProperties() {
        getters = [:]
    }
}


extension NSObjectTypeDelegate {
    private func defaultGetterForProperty(named name: String) -> Getter? {
        guard T.instancesRespond(to: NSSelectorFromString(name)) else {
            return nil
        }

        return { object in
            .init(object.value(forKey: name))
        }
    }
}
