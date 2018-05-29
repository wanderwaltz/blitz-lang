class Breakfast {
    var x = "_"

    var y {
        return self.x + "z"
    }

    init(arg arg) {
        self.x += arg
    }

    func cook() {
        func closure(arg x) {
            print "" + self.x + x
            return x
        }

        return closure
    }

    func serve(who who) {
        print "Enjoy your breakfast, " + who
    }
}

var breakfast = Breakfast(arg: "some")

print breakfast.y

breakfast.x = "123"

print breakfast.y
