extension Method: CustomStringConvertible {
    var description: String {
        return "closure\(unboundCallSignature.selectorDescription)"
    }
}
