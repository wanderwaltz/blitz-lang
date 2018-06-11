import Foundation

public struct FileSystemImportedModulesSourceProvider: ImportedModulesSourceProvider {
    public init(prefix: String, extension: String = "blitz") {
        self.prefix = prefix
        self.extension = `extension`
    }

    public func sourceForModule(named name: String) throws -> String {
        let url = URL(fileURLWithPath: prefix).appendingPathComponent(name).appendingPathExtension(`extension`)
        return try String(contentsOf: url, encoding: .utf8)
    }

    private let prefix: String
    private let `extension`: String
}
