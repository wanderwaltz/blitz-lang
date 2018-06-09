extension Class {
    func lookupMethod(named name: String) -> Method? {
        if let method = methods[name] {
            return method
        }

        if let superclass = self.superclass {
            return superclass.lookupMethod(named: name)
        }

        return nil
    }
}
