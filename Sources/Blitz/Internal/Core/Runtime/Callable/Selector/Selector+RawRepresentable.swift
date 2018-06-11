extension Selector: RawRepresentable {
    var rawValue: String {
        return "\(name)\(signature.selectorDescription)"
    }

    init?(rawValue: String) {
        guard rawValue.last == ")" else {
            return nil
        }

        guard case let components = rawValue.dropLast().components(separatedBy: "("),
            components.count == 2 else {
                return nil
        }

        let name = components[0]
        let rawParameterLabels = components[1]

        guard !rawParameterLabels.isEmpty else {
            self.init(
                name: name,
                signature: .void
            )
            return
        }

        guard rawParameterLabels.last == ":" else {
            return nil
        }

        let parameterLabels = rawParameterLabels.dropLast().components(separatedBy: ":")

        self.init(
            name: name,
            signature: .init(
                components: parameterLabels
            )
        )
    }
}
