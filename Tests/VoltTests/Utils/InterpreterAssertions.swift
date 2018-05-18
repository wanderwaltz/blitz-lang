import XCTest
@testable import Volt

let FLOAT_TOLERANCE = 1e-7

func expect_source(_ source: String,
                   yields boolValue: Bool,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result, _ in
        switch result {
        case let .value(value):
            switch value {
            case let .bool(result):
                XCTAssertEqual(result, boolValue, file: file, line: line)

            default:
                XCTFail("Type mismatch: expected Bool, got \(value)", file: file, line: line)
            }

        case let .runtimeError(error):
            XCTFail("Runtime error occurred: \(error)", file: file, line: line)

        case let .throwable(command):
            XCTFail("Unhandled throwable command: \(command)", file: file, line: line)
        }
    })
}

func expect_source(_ source: String,
                   yields stringValue: String,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result, _ in
        switch result {
        case let .value(value):
            switch value {
            case let .string(result):
                XCTAssertEqual(result, stringValue, file: file, line: line)

            default:
                XCTFail("Type mismatch: expected String, got \(value)", file: file, line: line)
            }

        case let .runtimeError(error):
            XCTFail("Runtime error occurred: \(error)", file: file, line: line)

        case let .throwable(command):
            XCTFail("Unhandled throwable command: \(command)", file: file, line: line)
        }
    })
}

func expect_source(_ source: String,
                   yields numberValue: Number,
                   tolerance: Double = 0.0,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result, _ in
        switch result {
        case let .value(value):
            switch value {
            case let .number(result):
                XCTAssertEqual(result, numberValue, accuracy: tolerance, file: file, line: line)

            default:
                XCTFail("Type mismatch: expected \(Number.self), got \(value)", file: file, line: line)
            }

        case let .runtimeError(error):
            XCTFail("Runtime error occurred: \(error)", file: file, line: line)

        case let .throwable(command):
            XCTFail("Unhandled throwable command: \(command)", file: file, line: line)
        }
    })
}

func expect_source_yields_nil(_ source: String,
                              file: StaticString = #file,
                              line: UInt = #line) {
    with_result_of_interpreting(source, do: { result, _ in
        switch result {
        case let .value(value):
            switch value {
            case .nil:
                break

            default:
                XCTFail("Type mismatch: expected nil, got \(value)", file: file, line: line)
            }

        case let .runtimeError(error):
            XCTFail("Runtime error occurred: \(error)", file: file, line: line)

        case let .throwable(command):
            XCTFail("Unhandled throwable command: \(command)", file: file, line: line)
        }
    })
}

func expect_source(_ source: String,
                   prints expectedStrings: [String],
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result, delegate in
        switch result {
        case .value:
            let printedStrings = delegate.printedValues.map({ String(describing: $0) })
            XCTAssertEqual(expectedStrings, printedStrings, file: file, line: line)

        case let .runtimeError(error):
            XCTFail("Runtime error occurred: \(error)", file: file, line: line)

        case let .throwable(command):
            XCTFail("Unhandled throwable command: \(command)", file: file, line: line)
        }
    })
}

func expect_source(_ source: String,
                   yields runtimeErrorCode: RuntimeError.Code,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result, _ in
        switch result {
        case let .value(value):
            XCTFail("Unexpected value returned: \(value), expected runtime error", file: file, line: line)

        case let .runtimeError(error):
            XCTAssertEqual(
                error.code,
                runtimeErrorCode, "Expected error code \(runtimeErrorCode), got \(error.code)",
                file: file,
                line: line
            )

        case let .throwable(command):
            XCTFail("Unhandled throwable command: \(command)", file: file, line: line)
        }
    })
}

func expect_source(_ source: String,
                   yields_parse_error expectedMessage: String,
                   file: StaticString = #file,
                   line: UInt = #line) {
     do {
         let tokens = try Scanner().process(source)
         let ast = try Parser().parse(tokens)
         let interpreter = ASTInterpreter()
         let resolver = ASTResolver(interpreter: interpreter)
         try resolver.resolve(ast)
         let result = interpreter.execute(ast)
         XCTFail("Unexpected result received: \(result) (expected a parser error)", file: file, line: line)
     }
     catch let parserError as ParserError {
         XCTAssertEqual(parserError.message, expectedMessage, file: file, line: line)
     }
     catch let error {
         XCTFail("Unexpected error: \(error)", file: file, line: line)
     }
}

func with_result_of_interpreting(_ source: String,
                                 do block: (ASTInterpreterResult, MockInterpreterDelegate) -> Void,
                                 file: StaticString = #file,
                                 line: UInt = #line) {
    do {
        let tokens = try Scanner().process(source)
        let ast = try Parser().parse(tokens)
        let interpreter = ASTInterpreter()
        let delegate = MockInterpreterDelegate()
        interpreter.delegate = delegate
        let resolver = ASTResolver(interpreter: interpreter)
        try resolver.resolve(ast)
        block(interpreter.execute(ast), delegate)
    }
    catch let error {
        XCTFail("Unexpected error: \(error)", file: file, line: line)
    }
}
