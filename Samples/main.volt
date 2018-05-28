class Breakfast {
    func cook() {
        func closure(arg x) {
            print " " + self + x
        }

        return closure
    }

    func serve(who who) {
        print "Enjoy your breakfast, " + who
    }
}

print "class: " + Breakfast

var breakfast = Breakfast()

print "instance: " + breakfast

let closure = breakfast.cook()
breakfast = nil

closure(arg: "qwerty")
