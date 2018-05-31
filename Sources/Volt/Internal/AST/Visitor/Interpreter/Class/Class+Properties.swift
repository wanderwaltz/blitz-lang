extension Class {
    func enumerateStoredProperties(with block: (StoredProperty) -> Void) {
        if let superclass = self.superclass {
            superclass.enumerateStoredProperties(with: block)
        }

        for property in storedProperties.values {
            block(property)
        }
    }

    func lookupStoredProperty(named name: String) -> StoredProperty? {
        if let property = storedProperties[name] {
            return property
        }

        if let superclass = self.superclass {
            return superclass.lookupStoredProperty(named: name)
        }

        return nil
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
