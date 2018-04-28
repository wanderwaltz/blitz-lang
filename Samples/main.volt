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

for (var i = 0; i < 10; i = i + 1) {
    print i
}
