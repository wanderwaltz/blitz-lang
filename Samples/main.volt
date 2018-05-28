class Breakfast {
    func cook() {
        print "Eggs a-fryin'!"
    }

    func serve(who who) {
        print "Enjoy your breakfast, " + who
    }
}

print "class: " + Breakfast

let breakfast = Breakfast()

print "instance: " + breakfast

breakfast.cook()
breakfast.serve(who: "World!")
