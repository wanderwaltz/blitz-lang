import Volt
import Foundation

final class Bar {

}

final class Foo {
    var intArray: [Int] = [1, 2, 3]
    var barArray: [Bar] = [.init(), .init(), .init()]

    var nullableInt: Int?
    var nullableString: String?
}

guard let sourceFileName = CommandLine.arguments.last, CommandLine.arguments.count == 2 else {
    print("expected a file name")
    exit(1)
}


do {
    let source = try String(contentsOf: URL(fileURLWithPath: sourceFileName), encoding: .utf8)

    let vm = VM()
    vm.importedModulesSourceProvider = FileSystemImportedModulesSourceProvider(prefix: "Samples")

    vm.defineClass0(initializer: Foo.init)
        .registerMutableProperty(named: "intArray", keyPath: \.intArray)
        .registerMutableProperty(named: "barArray", keyPath: \.barArray)
        .registerMutableProperty(named: "nullableInt", keyPath: \.nullableInt)
        .registerMutableProperty(named: "nullableString", keyPath: \.nullableString)

    let program = try vm.parse(source)

    print(program)

    try vm.execute(program)
}
catch let error {
    print(error)
    exit(2)
}
