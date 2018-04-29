import sample_module

let x = 123

{
    if x > 1000 {
        print "> 1000"
    }
    else if x > 100 {
        print "> 100"
    }
    else {
        print("else")
    }
}

print x
print y

print nil or "yes"

print 1 + false ?? 2

var i = 10

while i > 0 {
    print i
    i = i - 1

    if i == 5 {
        print "break here"
        break
    }
}

print "testing for statement"

print "testing continue in for loop"

for (var i = 0; i < 10; i += 1) {
    if i == 5 {
        continue
    }

    print i
}

print "testing arithmetic-assignment operators"

var q = 5

q += 1

print q

q -= 1

print q

q *= 2

print q

let w = q /= 2

print q
print w

print "testing defer"
{
    print "block 1"

    defer {
        print "first defer 1"
        print "first defer 2"
    }

    defer {
        print "second defer 1"
        print "second defer 2"
    }

    print "block 2"
}

print "testing defer in for loop"

for (var i = 0; i < 10; i += 1) {
    defer {
        print "deferred " + i
    }

    if i == 5 {
        continue
    }

    print i
}
