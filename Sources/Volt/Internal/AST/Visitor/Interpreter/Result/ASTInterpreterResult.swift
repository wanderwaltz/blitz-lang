enum ASTInterpreterResult {
case value(Value)
case runtimeError(RuntimeError)
case throwable(ASTInterpreterThrowableCommand)
}
