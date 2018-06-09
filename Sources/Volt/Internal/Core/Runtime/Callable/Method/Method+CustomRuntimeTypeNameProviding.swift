extension Method: CustomRuntimeTypeNameProviding {
    var customRuntimeTypeName: String {
        return "Method<\(String(describing: InstanceType.self))>"
    }
}
