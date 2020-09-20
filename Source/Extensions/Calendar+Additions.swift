//
//  Calendar+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 15/09/2020.
//

public extension Calendar {
    
    // MARK: ENUMS
    
    /// Enum of the days of week

    enum Months: Int, CustomStringConvertible, CustomReflectable {
                
        case current = 0, january, february, march, april, may, june, july, august, september, october, november, december
        
        // MARK: Public methods
        
        /// Gets the symbol of month
        ///
        /// Usage:
        ///
        ///     let month: Date.Months = .january
        ///     month.getMonthSymbols() // result -> January
        ///
        /// - Returns: String with the short format of month
        public func getMonthSymbols() -> String? {
            return DateFormatter().monthSymbols.getElement(indexOfElements)
        }
        
        /// Gets the short symbol of month
        ///
        /// Usage:
        ///
        ///     let month: Date.Months = .january
        ///     month.getShortWeekdaySymbols() // result -> Jan
        ///
        /// - Returns: String with the short format of month
        public func getShortMonthSymbols() -> String? {
            return DateFormatter().shortMonthSymbols.getElement(indexOfElements)
        }
        
        /// Get the very short symbol of month
        ///
        /// Usage:
        ///
        ///     let month: Date.WeekDays = .january
        ///     month.getVeryShortMonthSymbols() // result -> J
        ///
        /// - Returns: String with the short format of day
        public func getVeryShortMonthSymbols() -> String? {
            return DateFormatter().veryShortMonthSymbols.getElement(indexOfElements)
        }
        
        // MARK: Private methods
        
        /// Gets the correct index of element
        var indexOfElements: Int {
            
            // get index switch rawValue
            let index = rawValue > 0 ? rawValue : Calendar.currentUTC.month
            
            // return the correct index minus 1 in order to be equals to array of DateFormatter()
            return index - 1
        }
        
        // MARK: description
        public var description: String {
            return DateFormatter().monthSymbols.getElement(indexOfElements) ?? ""
        }
        
        public var customMirror: Mirror {
            return Mirror(reflecting: description)
        }
    }
    
    /// Enum of the days of week
    enum WeekDays: Int {
        
        case sunday = 0, monday, tuesday, wednesday, thursday, friday, saturday
        
        // MARK: Public methods
        
        /// Gets the short symbol of day
        ///
        /// Usage:
        ///
        ///     let day: Date.WeekDays = .friday
        ///     day.getShortWeekdaySymbols() // result -> Fri
        ///
        /// - Returns: String with the short format of day
        public func getShortWeekdaySymbols() -> String? {
            return DateFormatter().shortWeekdaySymbols.getElement(self.rawValue)
        }
        
        /// Gets the very short symbol of day
        ///
        /// Usage:
        ///
        ///     let day: Date.WeekDays = .friday
        ///     day.getVeryShortWeekdaySymbols() // result -> F
        ///
        /// - Returns: String with the short format of day
        public func getVeryShortWeekdaySymbols() -> String? {
            return DateFormatter().veryShortWeekdaySymbols.getElement(self.rawValue)
        }
    }
    
    // MARK: VARS
    
    /// Gets the current calendar with UTC TimeZone
    static var currentUTC: Calendar {
        get {
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale.current
            
            if let timeZone = TimeZone(abbreviation: "UTC") {
                calendar.timeZone = timeZone
            }
            
            return calendar
        }
    }
    
    /// Gets the first day of current month
    var firstDayOfCurrentMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
    }
    
    /// Gets the last day of current month
    var lastDayOfCurrentMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfCurrentMonth)!
    }
    
    /// Gets current year
    var year: Int {
        return Date().year
    }
    
    /// Gets current month
    var month: Int {
        return Date().month
    }
    
    /// Gets current day
    var day: Int {
        return Date().day
    }
    
    /// Gets current hour
    var hour: Int {
        return Date().hour
    }
    
    /// Gets current minutes
    var minute: Int {
        return Date().minute
    }
    
    /// Gets current minutes
    var today: Date {
        return Date()
    }
    
    // MARK: Public methods
    
    /// Gets number of days in a specific year, if the year is not specified, the current year will be taken by default.
    ///
    /// - Parameter year: The year of which you want to calculate the days
    ///
    /// - Returns: The number of days in a specific year, otherwise 0
    func getDaysOfYear(year: Int = 0) -> Int {
        
        var date: Date?
        
        // Specify the year to Date
        var dateComponents = DateComponents()
        dateComponents.year = year == 0 ? Calendar.currentUTC.year : year
        
        // Create date object
        date = self.date(from: dateComponents)
        
        // get the interval
        guard let interval = self.dateInterval(of: .year, for: date ?? Date()),
            let days = self.dateComponents([.day], from: interval.start, to: interval.end).day
            else {
                return 0
        }
                
        return days
    }
    
    /// Gets number of days in a specific month, if the month/year is not specified, the month/year will be the current.
    ///
    /// - Parameter month: The month of which you want to calculate the days
    /// - Parameter year: The year of which you want to calculate the days
    /// 
    /// - Returns: The number of days in a specific month, otherwise 0
    func getDaysOfMonth(month: Months = .current, year: Int = 0) -> Int {
                
        var date: Date?
        
        // Specify the months to Date
        var dateComponents = DateComponents()
        dateComponents.year = year == 0 ? Calendar.currentUTC.year : year
        dateComponents.month = month == .current ? Calendar.currentUTC.month : month.rawValue
        
        // Create date object
        date = self.date(from: dateComponents)
        
        // get the interval
        guard let interval = self.dateInterval(of: .month, for: date ?? Date()),
            let days = self.dateComponents([.day], from: interval.start, to: interval.end).day
            else {
                return 0
        }
                
        return days
    }
    
    /// Gets a specific date
    /// - Parameters:
    ///   - year: year
    ///   - month: month
    ///   - day: day
    /// - Returns: Date object
    func getDate(year: Int, month: Int, day: Int = 1) -> Date? {
        return date(from: DateComponents(year: year, month: month, day: day))
    }
    
    /// Checks if 2 dates are equals
    /// - Parameter date: date in order to compare
    /// - Returns: true if are equals, otherwhise false
    func isSameDate(date: Date) -> Bool {
        return date.year == self.year && date.month == self.month && date.day == self.day
    }
}
