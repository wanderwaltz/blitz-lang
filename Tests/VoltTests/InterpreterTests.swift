import XCTest
@testable import Volt

final class InterpreterTests: XCTestCase {}

extension InterpreterTests {
    func test__numbers() {
        expect_source("123", yields: 123)
        expect_source("-456", yields: -456)
        expect_source("0", yields: 0)
        expect_source("0 - 5", yields: -5)
        expect_source("1 + 2", yields: 3)
        expect_source("-5 + 6", yields: 1)
        expect_source("8 / 2", yields: 4)
        expect_source("5 * 6", yields: 30)
    }

    func test__bools() {
        expect_source("true", yields: true)
        expect_source("!false", yields: true)
        expect_source("not false", yields: true)

        expect_source("false", yields: false)
        expect_source("!true", yields: false)
        expect_source("not true", yields: false)
    }

    func test__number_comparisons() {
        expect_source("1 < 2", yields: true)
        expect_source("1 <= 2", yields: true)
        expect_source("1 > 2", yields: false)
        expect_source("1 >= 2", yields: false)

        expect_source("1 <= 1", yields: true)
        expect_source("1 <= 0", yields: false)

        expect_source("1 >= 1", yields: true)
        expect_source("1 >= 0", yields: true)

        expect_source("1 > -1", yields: true)

        expect_source("1 == 1", yields: true)
        expect_source("1 == 0.5 + 0.5", yields: true)
        
        expect_source("1 != 2", yields: true)
    }

    func test__strings() {
        expect_source("\"qwerty\"", yields: "qwerty")
        expect_source("\"qwerty\" + \"asdfg\"", yields: "qwertyasdfg")
    }

    func test__nil() {
        expect_source_yields_nil("nil")
    }
}


extension InterpreterTests {
    private func expect_source(_ source: String,
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

    private func expect_source(_ source: String,
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

    private func expect_source(_ source: String,
                               yields numberValue: Number,
                               file: StaticString = #file,
                               line: UInt = #line) {
        with_result_of_interpreting(source, do: { result in
            switch result {
            case let .value(value):
                switch value {
                case let .number(result):
                    XCTAssertEqual(result, numberValue, file: file, line: line)

                default:
                    XCTFail("Type mismatch: expected \(Number.self), got \(value)", file: file, line: line)
                }

            case let .runtimeError(error):
                XCTFail("Runtime error occurred: \(error)", file: file, line: line)
            }
        })
    }

    private func expect_source_yields_nil(_ source: String,
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

    private func with_result_of_interpreting(_ source: String,
                                             do block: (ASTInterpreterResult) -> Void,
                                             file: StaticString = #file,
                                             line: UInt = #line) {
        do {
            let tokens = try Scanner().process(source)
            let ast = try Parser().parse(tokens)
            let interpreter = ASTInterpreter()
            block(interpreter.evaluate(ast))
        }
        catch let error {
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        }
    }
}
