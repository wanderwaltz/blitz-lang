import Foundation

extension GenericError: LocalizedError {
    public var errorDescription: String? {
        return description
    }
}
