func append(_ right, to left) {
    return left + right
}

print append("World!", to: "Hello, ")
print append("World!", qwerty: "Hello, ") // should be an error
