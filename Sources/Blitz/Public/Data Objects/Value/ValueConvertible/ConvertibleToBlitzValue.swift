/// A protocol for converting some Swift value into Blitz value.
/// Used mainly in Value's generic initializer init<T>(_ any: T)
/// (see Value+Any.swift)
///
/// This is needed for custom conversions like Floats being
/// converted to Blitz's Number (aka Double) etc.
///
/// If type T does not conform to ConvertibleToBlitzValue, it still
/// can be represented as .object(T) in Blitz.
public protocol ConvertibleToBlitzValue {
    var blitzValue: Value { get }
}
