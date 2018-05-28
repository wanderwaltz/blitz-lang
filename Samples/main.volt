class Breakfast {
    var x = "_"
    let y = "z"

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

print breakfast.cook()(arg: "y")
