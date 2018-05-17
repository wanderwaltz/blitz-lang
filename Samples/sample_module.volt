var a = "global"

{
    func printA() {
        print a
    }

    printA()
    var a = "block"
    printA()
}
