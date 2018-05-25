struct CallSignature {
    let components: [String]

    init(components: [String?]) {
        self.components = components.map({ $0 ?? "_" })
    }
}
