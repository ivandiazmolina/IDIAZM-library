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
    
    /// Capitalize the first letter of a String
    ///
    /// - Returns: The same String with the first letter in uppercase
    ///
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
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
