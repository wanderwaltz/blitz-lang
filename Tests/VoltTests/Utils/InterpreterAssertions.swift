import XCTest
@testable import Volt

let FLOAT_TOLERANCE = 1e-7

func expect_source(_ source: String,
                   yields boolValue: Bool,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result in
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
        }
    })
}

func expect_source(_ source: String,
                   yields stringValue: String,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result in
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
        }
    })
}

func expect_source(_ source: String,
                   yields numberValue: Number,
                   tolerance: Double = 0.0,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result in
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
        }
    })
}

func expect_source_yields_nil(_ source: String,
                              file: StaticString = #file,
                              line: UInt = #line) {
    with_result_of_interpreting(source, do: { result in
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
        }
    })
}

func expect_source(_ source: String,
                   yields runtimeErrorCode: ASTIntepreterRuntimeError.Code,
                   file: StaticString = #file,
                   line: UInt = #line) {
    with_result_of_interpreting(source, do: { result in
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
        }
    })
}

func with_result_of_interpreting(_ source: String,
                                 do block: (ASTInterpreterResult) -> Void,
                                 file: StaticString = #file,
                                 line: UInt = #line) {
    do {
        let tokens = try Scanner().process(source)
        let ast = try Parser().parse(tokens)
        let interpreter = ASTInterpreter()
        block(interpreter.execute(ast))
    }
    catch let error {
        XCTFail("Unexpected error: \(error)", file: file, line: line)
    }
}
