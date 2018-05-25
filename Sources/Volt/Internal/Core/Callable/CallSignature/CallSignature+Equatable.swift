extension CallSignature: Equatable {
    static func == (left: CallSignature, right: CallSignature) -> Bool {
        return left.components == right.components
    }
}
