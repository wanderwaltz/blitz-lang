/// A protocol for converting some Swift value into Volt value.
/// Used mainly in Value's generic initializer init<T>(_ any: T)
/// (see Value+Any.swift)
///
/// This is needed for custom conversions like Floats being
/// converted to Volt's Number (aka Double) etc.
///
/// If type T does not conform to ConvertibleToVoltValue, it still
/// can be represented as .object(T) in Volt.
public protocol ConvertibleToVoltValue {
    var voltValue: Value { get }
}
