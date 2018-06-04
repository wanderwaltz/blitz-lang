enum InterpreterResult {
case value(Value)
case runtimeError(RuntimeError)
case throwable(InterpreterThrowableCommand)
}
