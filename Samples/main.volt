func q() {
    print "returned"
}

func test() {
    defer {
        print "deferred"
    }

    return q()
}

test()
