class Breakfast {
    func cook() {
        self.serve(who: self)
    }

    func serve(who who) {
        print "Enjoy your breakfast, " + who
    }
}

print "class: " + Breakfast

let breakfast = Breakfast()

print "instance: " + breakfast

breakfast.cook()
