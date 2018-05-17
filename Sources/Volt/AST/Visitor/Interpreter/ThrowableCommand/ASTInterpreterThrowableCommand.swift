enum ASTInterpreterThrowableCommand: Error {
case `break`
case `continue`
case `return`(Value)
}
