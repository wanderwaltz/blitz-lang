public protocol ErrorDomainProviding {
    static var errorDomain: String { get }
    static var errorDomainDescription: String { get }
}
