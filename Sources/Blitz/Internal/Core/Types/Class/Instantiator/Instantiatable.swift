/// A protocol for a type which can be instantiated as a Blitz value.
/// This usually represents a kind of class and is used by an
/// Instantiator object.
///
/// Instantiatable inherits Callable protocol assuming that instantiation
/// within Blitz source looks like this:
///
///    ClassName(args)
///
/// Thus the class named ClassName must be Callable.
protocol Instantiatable: Callable {
    /// Type of instances corresponding to this Instantiatable
    associatedtype InstanceType

    /// An instantiator object, which is used to provide a default Callable
    /// implementation for Instantiatable.
    var instantiator: Instantiator<Self> { get }
}


extension Instantiatable {
    var validCallSignatures: [CallSignature] {
        return instantiator.validCallSignatures
    }

    func call(with parameters: CallParameters) throws -> Value {
        return .object(try instantiator.instantiate(klass: self, with: parameters))
    }
}
