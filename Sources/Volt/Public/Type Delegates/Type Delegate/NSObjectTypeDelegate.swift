import Foundation

public final class NSObjectTypeDelegate<T: NSObject> {
    private let base = DefaultTypeDelegate<T>()
}


extension NSObjectTypeDelegate: TypeDelegate {
    public typealias Object = T

    public func getterForProperty(named name: String) -> Getter? {
        return base.getterForProperty(named: name) ?? defaultGetterForProperty(named: name)
    }

    public func setterForProperty(named name: String) -> Setter? {
        return base.setterForProperty(named: name) ?? defaultSetterForProperty(named: name)
    }

    public func registerProperty(named name: String, getter: @escaping Getter, setter: Setter?) {
        base.registerProperty(named: name, getter: getter, setter: setter)
    }

    public func unregisterProperty(named name: String) {
        base.unregisterProperty(named: name)
    }

    public func unregisterAllProperties() {
        base.unregisterAllProperties()
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

    private func defaultSetterForProperty(named name: String) -> Setter? {
        guard T.instancesRespond(to: NSSelectorFromString("set\(name.capitalized):")) else {
            return nil
        }

        return { object, value in
            object.setValue(value.any, forKey: name)
        }
    }
}
