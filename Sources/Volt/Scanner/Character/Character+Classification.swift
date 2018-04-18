import Foundation

extension Character {
    var isWhitespace: Bool {
        return whitespaceCharacters.contains(self)
    }

    var isNewline: Bool {
        return self == "\n"
    }

    var isDigit: Bool {
        return digitRange.contains(unicodeScalars.first!.value)
    }
}

private extension CharacterSet {
    func contains(_ character: Character) -> Bool {
        for scalar in character.unicodeScalars {
            if self.contains(scalar) {
                return true
            }
        }

        return false
    }
}

private let whitespaceCharacters = CharacterSet.whitespaces
private let digitRange = "0".unicodeScalars.first!.value..."9".unicodeScalars.first!.value
