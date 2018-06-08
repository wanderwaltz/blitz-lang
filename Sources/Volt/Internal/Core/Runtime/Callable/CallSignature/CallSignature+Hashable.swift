extension CallSignature: Hashable {
    var hashValue: Int {
        return components.map({ $0.hashValue }).reduce(0, ^)
    }

    static func == (left: CallSignature, right: CallSignature) -> Bool {
        return left.components == right.components
    }
}
