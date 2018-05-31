class Base {
    var property = "base property"
    var otherProperty

    var computedReadonlyProperty {
        "base computed readonly property"
    }

    var computedWritableProperty {
        get {
            self.property + " (computed)"
        }

        set {
            self.property = newValue + " (base)"
        }
    }

    init(arg otherProperty) {
        self.otherProperty = otherProperty
    }

    func method() {
        return self + " base method"
    }
}


class Derived: Base {
    var property = "overridden property" // should be an error

    var computedWritableProperty {
        get {
            super.computedWritableProperty + " (1)"
        }

        set {
            super.computedWritableProperty = newValue + " (2)"
        }
    }

    var computedReadonlyProperty {
        super.computedReadonlyProperty + " + overridden computed readonly property"
    }

    func method() {
        return super.method() + " overridden method"
    }
}

let instance = Derived()

// print instance.method()
// print instance.computedReadonlyProperty
instance.computedWritableProperty = 123
print instance.computedWritableProperty
print instance.property
