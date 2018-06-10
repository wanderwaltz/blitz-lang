extension TypeInfo {
    func enumerateStoredProperties(with block: (StoredProperty) -> Void) {
        if let supertype = self.supertype {
            supertype.enumerateStoredProperties(with: block)
        }

        for property in storedProperties.values {
            block(property)
        }
    }

    func lookupStoredProperty(named name: String) -> StoredProperty? {
        if let property = storedProperties[name] {
            return property
        }

        if let supertype = self.supertype {
            return supertype.lookupStoredProperty(named: name)
        }

        return nil
    }

    func lookupComputedProperty(named name: String) -> ComputedProperty? {
        if let property = computedProperties[name] {
            return property
        }

        if let supertype = self.supertype {
            return supertype.lookupComputedProperty(named: name)
        }

        return nil
    }
}
