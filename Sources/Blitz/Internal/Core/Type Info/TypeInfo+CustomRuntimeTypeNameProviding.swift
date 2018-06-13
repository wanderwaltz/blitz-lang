// MARK: - <CustomRuntimeTypeNameProviding> default implementation
extension TypeInfo {
    var customRuntimeTypeName: String {
        return "\(name).Type"
    }
}
