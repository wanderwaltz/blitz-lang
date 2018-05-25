func append(some right, _ left) {
    return left + right
}

func voidFunc() {
    return "qwerty"
}

print append(some: "World!", "Hello, ")
//print append("World!", qwerty: "Hello, ") // should be an error
