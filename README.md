# Blitz

TODOs:
- BlitzEquatable
- поддержка Dictionary
- учитывать signature при лукапе методов (overload)
   - для массива должно работать removing(at:) и removing(_:)
- тесты для Value+Interpreter
- метаметоды а-ля Squirrel
- унифицировать нативные классы и Class
   - Class станет генериком от InstanceType
- validCallSignatures можно сделать сетом
- тесты на Array
- BlitzStringConvertible работает только с print, нужно научить работать всегда
   - для этого ConvertibleFromBlitzValue должен уметь выполнять код
