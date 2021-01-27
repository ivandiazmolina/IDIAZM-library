//
//  UIColor+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 05/09/2020.
//

public extension UIColor {
    
    // MARK: static methods
    
    /// Get an instance of UIColor from String with HEX format, also you can set the alpha value
    /// - Parameter hex: color in HEX format
    /// - Parameter alpha: alpha value
    static func colorFrom(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if colorString.hasPrefix("#") { colorString.remove(at: colorString.startIndex) }
        
        if colorString.count != 6 { return UIColor.clear }
        
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0xFF) / 255.0,
            alpha: alpha
        )
    }
    
    /// Get an instance of UIColor from RGB values with optional alpha
    /// - Parameter red: red value
    /// - Parameter green: green value
    /// - Parameter blue: blue value
    /// - Parameter alpha: alpha value
    static func colorFrom(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
    
    /// Generate a random color with optional alpha
    /// - Parameter alpha: alpha value
    static func random(alpha: CGFloat = 1.0) -> UIColor {
        
        let max = CGFloat(UInt32.max)
        let red = CGFloat(arc4random()) / max
        let green = CGFloat(arc4random()) / max
        let blue = CGFloat(arc4random()) / max
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
