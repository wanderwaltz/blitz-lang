/// MARK: - <CustomRuntimeTypeNameProviding> default implementation
extension InstanceInfo {
    var customRuntimeTypeName: String {
        return klass.name
    }
}
