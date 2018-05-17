import sample_module

func makePoint(x, y) {
  func closure(method) {
    if (method == "x") { return x }
    if (method == "y") { return y }
    print "unknown method " + method
  }

  return closure
}

var point = makePoint(2, 3)
print point("x") // "2".
print point("y") // "3".
