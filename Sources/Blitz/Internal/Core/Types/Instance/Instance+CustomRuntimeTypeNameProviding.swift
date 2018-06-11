extension Instance: CustomRuntimeTypeNameProviding {
    var customRuntimeTypeName: String {
        return klass.name
    }
}
