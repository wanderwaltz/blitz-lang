final class Instance: InstanceInfo {
    typealias Klass = Class

    let klass: Class
    var storedProperties: [String: Value] = [:]

    init(klass: Class) {
        self.klass = klass

        klass.enumerateStoredProperties { property in
            storedProperties[property.name] = property.initialValue
        }
    }

    func lookupStoredProperty(named name: String) -> Value? {
        return storedProperties[name]
    }

    func setStoredProperty(named name: String, newValue: Value) throws {
        storedProperties[name] = newValue
    }
}
