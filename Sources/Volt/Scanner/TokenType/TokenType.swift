enum TokenType: Int {
// single-character tokens
case comma
case dot
case leftBrace
case leftParen
case rightBrace
case rightParen
case semicolon

// one or two character tokens
case bang
case bangEqual
case equal
case equalEqual
case greater
case greaterEqual
case less
case lessEqual
case minus
case minusEqual
case plus
case plusEqual
case questionQuestion
case slash
case slashEqual
case star
case starEqual

// literals
case identifier
case number
case string

// keywords
case `and`
case `break`
case `class`
case `continue`
case `defer`
case `else`
case `false`
case `for`
case `func`
case `if`
case `import`
case `let`
case `nil`
case `not`
case `or`
case `print`
case `return`
case `self`
case `super`
case `true`
case `var`
case `while`

case eof
}
