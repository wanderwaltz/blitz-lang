import Volt
import Foundation

guard let sourceFileName = CommandLine.arguments.last, CommandLine.arguments.count == 2 else {
    print("expected a file name")
    exit(1)
}


do {
    let source = try String(contentsOf: URL(fileURLWithPath: sourceFileName), encoding: .utf8)

    let vm = VM()

    let program = try vm.parse(source)

    print(program)

    try vm.execute(program)
}
catch let error {
    print(error)
    exit(2)
}
