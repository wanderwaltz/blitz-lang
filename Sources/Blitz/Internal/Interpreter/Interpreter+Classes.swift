extension Interpreter {
    func defineClass(_ classDeclaration: ClassDeclarationStatement) throws -> Value {
        let className = classDeclaration.name
        let location = className.location
        let superclass = try self.superclass(for: classDeclaration)
        let klass = try definingSuperIfNeeded(for: superclass, at: location) {
            Class(
                name: className.lexeme,
                supertype: superclass,
                instantiator: try instantiator(for: classDeclaration),
                storedProperties: try storedProperties(for: classDeclaration),
                computedProperties: computedProperties(for: classDeclaration),
                methods: try methods(for: classDeclaration)
            )
        }

        let value = Value(klass)
        try environment.defineVariable(named: className, value: value, isMutable: false)
        return value
    }

    private func superclass(for classDeclaration: ClassDeclarationStatement) throws -> Class? {
        guard let superclassName = classDeclaration.superclass else {
            return nil
        }

        let value = try lookupVariable(named: superclassName.identifier)

        guard case let .object(superclass as Class) = value else {
            throw RuntimeError.invalidSuperclass(value)
        }

        return superclass
    }

    /// If `superclass` is not `nil`, pushes a child environment where `super` variable is defined,
    /// and pops this environment when finished executing `block`. Otherwise (if `superclass` is `nil`),
    /// just executes the `block` without touching the environment.
    private func definingSuperIfNeeded<T>(for superclass: Class?,
                                          at location: SourceLocation,
                                          do block: () throws -> T) rethrows -> T {
        guard let superclass = superclass else {
            return try block()
        }

        environment = InterpreterEnvironment(parent: environment)
        environment.forceDefineVariable(
            named: .init(
                type: .super,
                lexeme: "super",
                location: location
            ),
            value: .init(superclass),
            isMutable: false
        )

        defer {
            guard let parentEnvironment = environment.parent else {
                preconditionFailure("should have created an environment for `super`")
            }

            environment = parentEnvironment
        }

        let result = try block()

        return result
    }

    private func instantiator(for classDeclaration: ClassDeclarationStatement) throws -> Class.Instantiator {
        precondition(classDeclaration.initializers.count > 0)
        guard classDeclaration.initializers.count > 1 else {
            return .init(
                Class.Method(
                    Function(
                        declaration: classDeclaration.initializers[0],
                        closure: environment
                    )
                )
            )
        }

        let initializerFunctions = classDeclaration.initializers.map({
            Function(
                declaration: $0,
                closure: environment
            )
        })

        let initializerMethods = initializerFunctions.map(Method.init)
        let overloadedInitializer = try overload(initializerMethods)

        return .init(overloadedInitializer)
    }

    private func storedProperties(for classDeclaration: ClassDeclarationStatement) throws -> [String: StoredProperty] {
        return .init(
            uniqueKeysWithValues: try classDeclaration.storedProperties.map({ propertyDeclaration in
                let property = try storedProperty(for: propertyDeclaration)
                return (property.name, property)
            })
        )
    }

    private func storedProperty(for declaration: VariableDeclarationStatement) throws -> StoredProperty {
        let name = declaration.identifier.lexeme
        let isMutable = declaration.keyword.type == .var
        let value = try evaluate(declaration.initializer)
        return StoredProperty(
            name: name,
            isMutable: isMutable,
            initialValue: value
        )
    }

    private func computedProperties(for classDeclaration: ClassDeclarationStatement) -> [String: Class.ComputedProperty] {
        return .init(
            uniqueKeysWithValues: classDeclaration.computedProperties.map({ declaration in
                let property = computedProperty(for: declaration)
                return (property.name, property)
            })
        )
    }

    private func computedProperty(for declaration: ComputedPropertyDeclarationStatement) -> Class.ComputedProperty {
        let name = declaration.name.lexeme

        return Class.ComputedProperty(
            name: name,
            getter: getter(for: declaration),
            setter: setter(for: declaration)
        )
    }

    private func getter(for computedProperty: ComputedPropertyDeclarationStatement) -> Class.Method {
        return Class.Method(
            Function(
                declaration: .init(
                    name: computedProperty.name,
                    parameters: [],
                    body: computedProperty.getter
                ),
                closure: environment
            )
        )
    }

    private func setter(for computedProperty: ComputedPropertyDeclarationStatement) -> Class.Method? {
        return computedProperty.setter.map({ setter in
            let location = computedProperty.name.location
            return Class.Method(
                Function(
                    declaration: .init(
                        name: computedProperty.name,
                        parameters: .singleParameterWithoutLabel(named: .newValue(at: location)),
                        body: setter
                    ),
                    closure: environment
                )
            )
        })
    }

    private func methods(for classDeclaration: ClassDeclarationStatement) throws -> [String: Class.Method] {
        let declarations = overloadedMethodDeclarations(for: classDeclaration)

        let methods: [(String, Class.Method)] = try declarations.map({ element in
            let (name, overloads) = element

            let overloadedMethods = overloads.map({
                Class.Method(Function(declaration: $0, closure: environment))
            })

            precondition(overloadedMethods.count > 0)

            if overloadedMethods.count > 1 {
                return (name, try overload(overloadedMethods))
            }
            else {
                return (name, overloadedMethods[0])
            }
        })

        return .init(uniqueKeysWithValues: methods)
    }

    private func overloadedMethodDeclarations(for classDeclaration: ClassDeclarationStatement)
        -> [String: [FunctionDeclarationStatement]] {
            var declarations: [String: [FunctionDeclarationStatement]] = [:]

            for methodDeclaration in classDeclaration.methods {
                let methodName = methodDeclaration.name.lexeme
                var overloadedDeclarations = declarations[methodName] ?? []
                overloadedDeclarations.append(methodDeclaration)
                declarations[methodName] = overloadedDeclarations
            }

            return declarations
        }
}
