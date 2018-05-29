class Base {
    var property = "base property"
    var otherProperty

    init(arg otherProperty) {
        self.otherProperty = otherProperty
    }

    func method() {
        return "base method"
    }
}


class Derived {
    func description() {
        "text"
    }
}

let instance = Derived()

print instance
