extension Function: CustomStringConvertible {
    var description: String {
        return "closure\(declaration.signature.selectorDescription)"
    }
}
