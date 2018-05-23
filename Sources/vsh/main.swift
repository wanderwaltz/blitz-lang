import Volt
import Foundation

final class TestNSObject: NSObject {
    @objc var qq = -1

    @objc func aa() -> Double {
        return 123.45
    }

    @objc init(arg1: Float, arg2: Int) {
        super.init()
        qq = Int(arg1-Float(arg2))
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

    try vm.defineNSObject2(initializer: TestNSObject.init)

    let program = try vm.parse(source)

    print(program)

    try vm.execute(program)
}
catch let error {
    print(error)
    exit(2)
}
