# Volt

TODOs:
- VoltEquatable
- поддержка Dictionary
- учитывать signature при лукапе методов (overload)
   - для массива должно работать removing(at:) и removing(_:)
- тесты для Value+Interpreter
- метаметоды а-ля Squirrel
- унифицировать нативные классы и Class
   - Class станет генериком от InstanceType
- validCallSignatures можно сделать сетом
- тесты на Array
- VoltStringConvertible работает только с print, нужно научить работать всегда
   - для этого ConvertibleFromVoltValue должен уметь выполнять код
