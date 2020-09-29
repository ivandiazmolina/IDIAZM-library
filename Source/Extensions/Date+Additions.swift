//
//  Date+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 05/09/2020.
//

public extension Date {
    
    /// Gets the start of day
    var startOfDay: Date {
        let calendar = Calendar.currentUTC
        return calendar.startOfDay(for: self)
    }
    
    /// Gets the end of day
    var endOfDay: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: DateComponents(day: -1, second: -1), to: startOfDay)!
    }
    
    
    /// Gets the first day of month
    var firstDayOfMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
    /// Checks if the day is the day of month
    var isFirstDayOfMonth: Bool {
        return self == firstDayOfMonth
    }
    
    /// Gets the last day of month
    var lastDayOfMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth)!
    }
    
    /// Gets days of month according to date
    var daysOfMonth: Int {
        let calendar = Calendar.currentUTC
        return calendar.range(of: .day, in: .month, for: self)!.count
    }
    
    /// Gets the first day of week
    var firstDayOfWeek: Date {
        let calendar = Calendar.currentUTC
        let firstWeekDay = calendar.firstWeekday
        let weekDayFirstDay = calendar.component(.weekday, from: self)
        
        let diff = weekDayFirstDay - firstWeekDay
        let firstDay = self.add(days: -(diff))
        return firstDay
    }
    
    /// Gets the last day of week
    var lastDayOfWeek: Date {
        let firstWeekDay = firstDayOfWeek
        
        let lastDay = firstWeekDay.add(days: 6)
        return lastDay
    }
    
    /// Gets current year
    var year: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.year, from: self)
    }
    
    /// Gets current month
    var month: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.month, from: self)
    }
    
    /// Gets current day
    var day: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.day, from: self)
    }
    
    /// Gets current hour
    var hour: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.hour, from: self)
    }
    
    /// Gets current minutes
    var minute: Int {
        let calendar = Calendar.currentUTC
        return calendar.component(.minute, from: self)
    }
    
    /// Add sor substracts years from date object
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
    
    /// Adds or substracts months from date object
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
    
    /// Adds or substracts weeks from date object
    ///
    /// Usage:
    ///
    ///     let date = Date()
    ///     date.add(weeks: 1) // add
    ///     date.add(weeks: -1) // subtract
    ///
    /// - Returns: String date formated
    func add(weeks: Int) -> Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: .day, value: weeks * 7, to: self)!
    }
    
    /// Adds or substracts days from date object
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
    
    /// Adds or substracts hours from date object
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
    
    /// Adds or substracts minutes from date object
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
    
    /// Converts a date to string with a specific format
    ///
    /// - Returns: String date formated
    func stringFromDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
