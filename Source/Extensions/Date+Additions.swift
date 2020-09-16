//
//  Date+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 05/09/2020.
//

public extension Date {
    
    /// Get the start of day
    var startOfDay: Date {
        let calendar = Calendar.currentUTC
        return calendar.startOfDay(for: self)
    }
    
    /// Get the end of day
    var endOfDay: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: DateComponents(day: -1, second: -1), to: startOfDay)!
    }
    
    
    /// Get the first day of month
    var firstDayOfMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
    /// Check if the day is the day of month
    var isFirstDayOfMonth: Bool {
        return self == firstDayOfMonth
    }
    
    /// Get the last day of month
    var lastDayOfMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth)!
    }
    
    /// Get current year
    var year: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.year, from: self)
    }
    
    /// Get current month
    var month: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.month, from: self)
    }
    
    /// Get current day
    var day: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.day, from: self)
    }
    
    /// Get current hour
    var hour: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.hour, from: self)
    }
    
    /// Get current minutes
    var minute: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.minute, from: self)
    }
    
    /// Add or substract years from date object
    ///
    /// Usage:
    ///
    ///     let date = Date()
    ///     date.add(years: 1) // add
    ///     date.add(years: -1) // subtract
    ///
    /// - Returns: String date formated
    func add(years: Int) -> Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: .year, value: years, to: self)!
    }
    
    /// Add or substract months from date object
    ///
    /// Usage:
    ///
    ///     let date = Date()
    ///     date.add(months: 1) // add
    ///     date.add(months: -1) // subtract
    ///
    /// - Returns: String date formated
    func add(months: Int) -> Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: .month, value: months, to: self)!
    }
    
    /// Add or substract days from date object
    ///
    /// Usage:
    ///
    ///     let date = Date()
    ///     date.add(days: 1) // add
    ///     date.add(days: -1) // subtract
    ///
    /// - Returns: String date formated
    func add(days: Int) -> Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    /// Add or substract hours from date object
    ///
    /// Usage:
    ///
    ///     let date = Date()
    ///     date.add(hours: 1) // add
    ///     date.add(hours: -1) // subtract
    ///
    /// - Returns: String date formated
    func add(hours: Int) -> Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: .hour, value: hours, to: self)!
    }
    
    /// Add or substract minutes from date object
    ///
    /// Usage:
    ///
    ///     let date = Date()
    ///     date.add(minutes: 1) // add
    ///     date.add(minutes: -1) // subtract
    ///
    /// - Returns: String date formated
    func add(minutes: Int) -> Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    /// Convert a date to string with a specific format
    ///
    /// - Returns: String date formated
    func stringFromDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
