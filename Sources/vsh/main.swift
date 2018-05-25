import Volt
import Foundation

final class TestClass {
    var text = ""

    func parenthesize(adding prefix: String) -> String {
        return "\(prefix)(\(text))"
    }
}

guard let sourceFileName = CommandLine.arguments.last, CommandLine.arguments.count == 2 else {
    print("expected a file name")
    exit(1)
}


do {
    let source = try String(contentsOf: URL(fileURLWithPath: sourceFileName), encoding: .utf8)

    let vm = VM()
    vm.importedModulesSourceProvider = FileSystemImportedModulesSourceProvider(prefix: "Samples")

    let program = try vm.parse(source)

    try vm.defineClass0(initializer: TestClass.init)
        .registerMutableProperty(named: "text", keyPath: \.text)
        .registerMethod(named: "parenthesize", method: TestClass.parenthesize)

    print(program)

    try vm.execute(program)
}
catch let error {
    print(error)
    exit(2)
}
