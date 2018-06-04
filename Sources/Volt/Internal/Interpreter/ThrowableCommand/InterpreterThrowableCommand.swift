enum InterpreterThrowableCommand: Error {
case `break`
case `continue`
case `return`(Value)
}
