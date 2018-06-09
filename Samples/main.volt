// let foo = Foo()
//
// print foo.nullableInt
// print type(of: foo.nullableInt)
//
// print foo.nullableInt = 123
// print foo.nullableInt
// print type(of: foo.nullableInt)
//
// print foo.nullableString
// print type(of: foo.nullableString)
//
// print foo.nullableString = 123.456
// print type(of: foo.nullableString)
//
// print type(of: foo.intArray)
// print foo.intArray.count
// print foo.intArray.isEmpty
// print foo.intArray.first
// print foo.intArray.last
// print foo.intArray = foo.intArray.appending(4)
// print foo.intArray = foo.intArray.inserting(5, at: 2)
// print foo.intArray.removing(at: 2)

// var arr = [1, "qwerty", true] + [nil, "asdg"]
//
// arr += ["zcvb"]
//
// print arr
//
// print type(of: arr)
// print arr[0]
// print arr[1]
// print arr[2]

func overloaded(first arg) {
    print ">>> " + arg
}

func overloaded(second arg) {
    print "]]] " + arg
}

overloaded(first: 123)
overloaded(second: 123)
