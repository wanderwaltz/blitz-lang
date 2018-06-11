import Foundation

extension GenericError: CustomNSError {
    public static var errorDomain: String {
        return Code.errorDomain
    }

    public var errorCode: Int {
        return code.rawValue
    }
}
