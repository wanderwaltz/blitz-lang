final class Instance {
    let klass: Class
    var storedProperties: [String: Value] = [:]

    init(klass: Class) {
        self.klass = klass

        klass.enumerateStoredProperties { property in
            storedProperties[property.name] = property.initialValue
        }
    }
}
