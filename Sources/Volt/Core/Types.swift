typealias Number = Double

enum Literal {
case number(Number)
case string(String)
}

extension Literal: CustomStringConvertible {
    var description: String {
        switch self {
        case let .number(value): return String(describing: value)
        case let .string(value): return "\"\(value)\""
        }
    }
}
