final class Instance {
    let klass: Class
    var storedProperties: [String: Value] = [:]

    init(klass: Class) {
        self.klass = klass

        for property in klass.storedProperties.values {
            storedProperties[property.name] = property.initialValue ?? .nil
        }
    }
}
