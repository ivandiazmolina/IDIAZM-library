//
//  Calendar+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 15/09/2020.
//

public extension Calendar {
    
    // MARK: VARS
    
    /// Get the current calendar with UTC TimeZone
    static var currentUTC: Calendar {
        get {
            var calendar = Calendar(identifier: .gregorian)
            
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
    
    // MARK: Public methods
    
    /// Get number of days in a specific year, if the year is not specified, the current year will be taken by default.
    ///
    /// - Parameter year: The year of which you want to calculate the days
    ///
    /// - Returns: The number of days in a specific year, otherwise 0
    func getDaysOfYear(year: Int = 0) -> Int {
        
        var date: Date?
        
        if year != 0 {
            // Specify the year to Date
            var dateComponents = DateComponents()
            dateComponents.year = year
            
            // Create date object
            date = self.date(from: dateComponents)
        }
        
        // get the interval
        guard let interval = self.dateInterval(of: .year, for: date ?? Date()),
            let days = self.dateComponents([.day], from: interval.start, to: interval.end).day
            else {
                return 0
        }
                
        return days
    }
    
    /// Get number of days in a specific month, if the month is not specified, the current month will be taken by default.
    ///
    /// - Parameter month: The month of which you want to calculate the days
    /// 
    /// - Returns: The number of days in a specific month, otherwise 0
    func getDaysOfMonth(month: Int = 0) -> Int {
        
        var date: Date?
        
        if month != 0 {
            // Specify the months to Date
            var dateComponents = DateComponents()
            dateComponents.month = month
            
            // Create date object
            date = self.date(from: dateComponents)
        }
        
        // get the interval
        guard let interval = self.dateInterval(of: .month, for: date ?? Date()),
            let days = self.dateComponents([.day], from: interval.start, to: interval.end).day
            else {
                return 0
        }
                
        return days
    }
}
