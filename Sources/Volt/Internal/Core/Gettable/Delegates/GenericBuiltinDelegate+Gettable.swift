extension GenericBuiltinDelegate {
    func bind(_ object: Object) -> AnyGettable {
        let getters = self.getters

        return AnyGettable({ propertyName in
            guard let getter = getters[propertyName] else {
                throw InternalError.unknownProperty(named: propertyName)
            }

            return getter(object)
        })
    }
}
