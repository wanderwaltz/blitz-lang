class Breakfast {
    init(arg arg) {
        print "init called with arg: " + arg
    }

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

var breakfast = Breakfast(arg: "some")

print "instance: " + breakfast

let closure = breakfast.cook()
breakfast = nil

closure(arg: "qwerty")
