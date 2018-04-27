enum TokenType: Int {
// single-character tokens
case comma
case dot
case leftBrace
case leftParen
case minus
case plus
case rightBrace
case rightParen
case slash
case star

// one or two character tokens
case bang
case bangEqual
case equal
case equalEqual
case greater
case greaterEqual
case less
case lessEqual
case questionQuestion

// literals
case identifier
case number
case string

// keywords
case `and`
case `class`
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
