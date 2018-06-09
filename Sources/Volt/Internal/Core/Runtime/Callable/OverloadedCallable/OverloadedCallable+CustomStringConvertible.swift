extension OverloadedCallable: CustomStringConvertible {
    var description: String {
        let overloads = self.overloads
            .keys
            .map({ $0.selectorDescription })
            .sorted()
            .joined(separator: "|")

        return "closure[\(overloads)]"
    }
}
