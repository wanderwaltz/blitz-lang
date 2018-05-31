extension Class {
    func lookupMethod(named name: String) -> Function? {
        if let method = methods[name] {
            return method
        }

        if let superclass = self.superclass {
            return superclass.lookupMethod(named: name)
        }

        return nil
    }
}
