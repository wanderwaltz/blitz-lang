/// Selector represents a method name and its arguments signature and
/// is used for registering native closures as Blitz methods.
///
/// Usually Selector is represented as a string in a following format:
///
///    init(code:message:location:)
///
/// Here the method name is `init` and it has three arguments with
/// the `code`, `message` and `location` labels.
///
/// This whole concept is inspired by Objective-C's selectors, but
/// its semantics are somewhat different here.
struct Selector {
    let name: String
    let signature: CallSignature

    init(name: String, signature: CallSignature) {
        self.name = name
        self.signature = signature
    }
}
