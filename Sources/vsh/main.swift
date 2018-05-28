import Volt
import Foundation

final class TestClass {
    var text = ""

    init(text: String) {
        self.text = text
    }

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

    try vm.defineClass1(selector: "TestClass(text:)", initializer: TestClass.init)
        .registerMutableProperty(named: "text", keyPath: \.text)
        .registerMethod(selector: "parenthesize(adding:)", method: TestClass.parenthesize)

    try vm.defineGlobalFunc1(selector: "greet(who:)", func: { (who: Any) -> String in
        return "Hello, \(who)"
    })

    print(program)

    try vm.execute(program)
}
catch let error {
    print(error)
    exit(2)
}
