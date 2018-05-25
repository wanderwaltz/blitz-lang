extension Selector: Equatable {
    static func == (left: Selector, right: Selector) -> Bool {
        return left.name == right.name && left.signature == right.signature
    }
}
