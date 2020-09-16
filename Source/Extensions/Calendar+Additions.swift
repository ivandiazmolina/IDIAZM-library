//
//  Calendar+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 15/09/2020.
//

public extension Calendar {
    
    // MARK: ENUMS
    
    /// Enum of the days of week

    enum Months: Int {
        case current = 0, january, february, march, april, may, june, july, august, september, october, november, december
    }
    
    /// Enum of the days of week
    enum WeekDays: Int {
        
        case sunday = 0, monday, tuesday, wednesday, thursday, friday, saturday
        
        private func dateFormatter() -> DateFormatter {
            let dateFormatter = DateFormatter()
            return dateFormatter
        }
        
        /// Get the short symbol of day
        ///
        /// Usage:
        ///
        ///     let day: Date.WeekDays = .friday
        ///     day.getShortWeekdaySymbols() // result -> Fri
        ///
        /// - Returns: String with the short format of day
        public func getVeryShortWeekdaySymbols() -> String? {
            return dateFormatter().veryShortWeekdaySymbols.getElement(self.rawValue)
        }
        
        /// Get the short symbol of day
        ///
        /// Usage:
        ///
        ///     let day: Date.WeekDays = .friday
        ///     day.getShortWeekdaySymbols() // result -> F
        ///
        /// - Returns: String with the short format of day
        public func getShortWeekdaySymbols() -> String? {
            return dateFormatter().shortWeekdaySymbols.getElement(self.rawValue)
        }
    }
    
    // MARK: VARS
    
    /// Get the current calendar with UTC TimeZone
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
    
    /// Get the first day of current month
    var firstDayOfCurrentMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
    }
    
    /// Get the last day of current month
    var lastDayOfCurrentMonth: Date {
        let calendar = Calendar.currentUTC
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfCurrentMonth)!
    }
    
    /// Get current year
    var year: Int {
        return Date().year
    }
    
    /// Get current month
    var month: Int {
        return Date().month
    }
    
    /// Get current day
    var day: Int {
        return Date().day
    }
    
    /// Get current hour
    var hour: Int {
        return Date().hour
    }
    
    /// Get current minutes
    var minute: Int {
        return Date().minute
    }
    
    // MARK: Public methods
    
    /// Get number of days in a specific year, if the year is not specified, the current year will be taken by default.
    ///
    /// - Parameter year: The year of which you want to calculate the days
    ///
    /// - Returns: The number of days in a specific year, otherwise 0
    func getDaysOfYear(year: Int = 0) -> Int {
        
        var date: Date?
        
        // Specify the year to Date
        var dateComponents = DateComponents()
        dateComponents.year = year == 0 ? Date().year : year
        
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
    
    /// Get number of days in a specific month, if the month/year is not specified, the month/year will be the current.
    ///
    /// - Parameter month: The month of which you want to calculate the days
    /// - Parameter year: The year of which you want to calculate the days
    /// 
    /// - Returns: The number of days in a specific month, otherwise 0
    func getDaysOfMonth(month: Months = .current, year: Int = 0) -> Int {
        
        //case sunday = 0, monday, tuesday, wednesday, thursday, friday, saturday
        
        var date: Date?
        
        // Specify the months to Date
        var dateComponents = DateComponents()
        dateComponents.year = year == 0 ? Date().year : year
        dateComponents.month = month == .current ? Date().month : month.rawValue
        
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
}
