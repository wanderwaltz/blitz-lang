struct ComputedProperty<_InstanceType> {
    typealias InstanceType = _InstanceType
    typealias Method = Blitz.Method<InstanceType>

    let name: String
    let getter: Method
    let setter: Method?
}
