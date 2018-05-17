func makeCounter() {
    var i = 0
    func count() {
        i = i + 1
        print i
    }

    return count
}

var counter = makeCounter()
counter() // "1".
counter() // "2".
