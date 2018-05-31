extension Class {
    func enumerateStoredProperties(with block: (StoredProperty) -> Void) {
        if let superclass = self.superclass {
            superclass.enumerateStoredProperties(with: block)
        }

        for property in storedProperties.values {
            block(property)
        }
    }

    func lookupComputedProperty(named name: String) -> ComputedProperty? {
        if let property = computedProperties[name] {
            return property
        }

        if let superclass = self.superclass {
            return superclass.lookupComputedProperty(named: name)
        }

        return nil
    }
}
