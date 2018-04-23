enum TokenType: Int {
// single-character tokens
case leftParen
case rightParen
case leftBrace
case rightBrace
case comma
case dot
case minus
case plus
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

// literals
case identifier
case string
case number

// keywords
case and
case `class`
case `else`
case `false`
case `func`
case `for`
case `if`
case `nil`
case `or`
case `not`
case `return`
case `super`
case `self`
case `true`
case `let`
case `var`
case `while`

case eof
}
