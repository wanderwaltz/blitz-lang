class Base {
    var _property = "base"

    var property {
        get {
            return self._property
        }

        set {
            self._property = newValue
        }
    }
}

class Derived: Base {
    var property {
        get {
            return super.property
        }

        set {
            super.property = newValue + " overridden"
        }
    }
}

let instance = Derived()
instance.property = "test"
// print instance.property
