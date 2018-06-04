public enum Value {
case `nil`
case bool(Bool)
case number(Number)
case string(String)
case array([Value])
case object(Any)
}
