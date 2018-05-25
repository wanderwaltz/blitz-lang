/// a-la Objective-C method selector, but Swift style
struct Selector {
    let name: String
    let signature: CallSignature

    init(name: String, signature: CallSignature) {
        self.name = name
        self.signature = signature
    }
}
