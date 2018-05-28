class Breakfast {
    init(arg arg) {
        if arg.length < 5 {
            print("init called with small arg")
            return
        }

        print "init called with arg: " + arg
    }

    func cook() {
        func closure(arg x) {
            print "" + self + x
            return x
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

print closure(arg: "qwerty")
