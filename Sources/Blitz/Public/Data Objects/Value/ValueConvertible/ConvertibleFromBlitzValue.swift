/// A protocol for converting from Blitz values to any Swift type.
///
/// This protocol is used in private `typecheck` function family
/// to side-step some rough edges in Swift's generics. Because
/// of that, the protocol's API may look strange.
///
/// It would be cleaner to use the following signature:
///
///    static func fromBlitzValue(_ value: Value) -> Self?
///
/// but this would make the ConvertibleFromBlitzValue a
/// generic protocol from Swift's type system standpoint
/// and would forbid dynamic casts such as
///
///    if let convertible = T0.self as? ConvertibleFromBlitzValue.Type,
///
/// which is used in `typecheck` function.
///
/// Returning Any? here allows us to perform this cast and furthemore
/// check that the returned value has the expected type:
///
///    if let convertible = T0.self as? ConvertibleFromBlitzValue.Type,
///       let v0 = convertible.fromBlitzValue(args[0]) as? T0 {
///
/// See Typecheck.swift for more info.
public protocol ConvertibleFromBlitzValue {
    static func fromBlitzValue(_ value: Value) -> Any?
}
