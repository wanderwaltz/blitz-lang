extension TypeInfo {
    func lookupMethod(named name: String) -> Method? {
        if let method = methods[name] {
            return method
        }

        if let supertype = self.supertype {
            return supertype.lookupMethod(named: name)
        }

        return nil
    }
}
