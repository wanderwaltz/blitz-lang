enum ASTInterpreterResult {
case value(Value)
case runtimeError(ASTIntepreterRuntimeError)
}
