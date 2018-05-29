class Breakfast {
    var x = "_"

    var y {
        return self.x + "z"
    }

    var z {
        get {
            return self.y
        }

        set {
            self.x = newValue
        }
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

print breakfast.z

breakfast.z = 123

print breakfast.z
print breakfast.x
