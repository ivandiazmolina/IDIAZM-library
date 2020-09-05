//
//  String+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 04/09/2020.
//

import UIKit

public extension String {
    
    // MARK: VARS
    
    /// Check if a String contains only digits
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    /// Check if a String contains only letters
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    var containsOnlyLetters: Bool {
        let notLetters = NSCharacterSet.letters.inverted
        return rangeOfCharacter(from: notLetters, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    /// Return the translation localized in the 'Localizable.string'
    ///
    /// - Returns: Translation of the key
    ///
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    // MARK: static methods
    
    /// Generate a hash with a length of 28 characters
    ///
    /// - Returns: String with a length of 28 characters
    ///
    static func generateHash() -> String {
        let length = 28
        let letters: NSString = "abcdefghijklmnopqrstuvwxyz0123456789-"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    // MARK: public methods
    
    /// Check if a String contains letters and digits
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    func isAlphanumeric() -> Bool {
        let notAlphanumeric = NSCharacterSet.decimalDigits.union(NSCharacterSet.letters).inverted
        return rangeOfCharacter(from: notAlphanumeric, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    /// Check if a String is a valid email
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    func isValidEmail() -> Bool {
        return self.evaluate(regexp: Constants.Patterns.email)
    }
    
    /// Check if a String is a valid strong password
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    func isValidStrongPassword() -> Bool {
        return self.evaluate(regexp: Constants.Patterns.strongPassword)
    }
    
    /// Check if a String is a valid DNI
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    func isValidDNI() -> Bool {
        return self.evaluate(regexp: Constants.Patterns.DNI)
    }
    
    /// Check if a String is a valid Phone
    ///
    /// - Returns: True if is valid, otherwise false
    ///
    func isValidPhone() -> Bool {
        return self.evaluate(regexp: Constants.Patterns.phoneNumber)
    }
    
    /// Capitalize the first letter of a String
    ///
    /// - Returns: The same String with the first letter in uppercase
    ///
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    /// Change the date format of the string
    ///
    /// - Returns: String with the new date format or empty if an error was found
    ///
    /// - Parameter inputFormat: current date format
    /// - Parameter outputFormat: new date format
    ///
    func formatDate(inputFormat: String, outputFormat: String) -> String {
        let inDateFormatter = DateFormatter()
        inDateFormatter.dateFormat = inputFormat
        guard let date = inDateFormatter.date(from: self) else {
            return ""
        }
        let outdateFormatter = DateFormatter()
        outdateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: outputFormat, options: 0, locale: Locale.current)
        return outdateFormatter.string(from: date)
    }
    
    /// Convert a String in to Bool
    ///
    /// - Returns: true or false if the conversion was successful, otherwise nil
    ///
    /// - Important:
    ///     supported values: ["true", "yes", "1", "false", "no", "0"]
    ///
    func toBool() -> Bool? {
        let trueValues = ["true", "yes", "1"]
        let falseValues = ["false", "no", "0"]
        let lowerSelf = self.lowercased()
        if trueValues.contains(lowerSelf) {
            return true
        } else if falseValues.contains(lowerSelf) {
            return false
        } else {
            return nil
        }
    }
    
    // MARK: private methods
    
    private func evaluate(regexp: String) -> Bool {
        guard let range = range(of: regexp, options: .regularExpression, range: nil, locale: nil) else {
            return false
        }
        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
}
