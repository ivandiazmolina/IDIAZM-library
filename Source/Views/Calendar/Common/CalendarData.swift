//
//  CalendarData.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 20/9/20.
//

public struct CalendarData {
    let currentDate = Date()
    var selectedDate = Date()
    var weekRange: [[Date]] = []
    var monthRange: [WeekRange] = []
}
