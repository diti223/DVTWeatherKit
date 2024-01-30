//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

extension Date {
    static func make(calendar: Calendar, year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 1) -> Date? {
        
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute
        )
        return calendar.date(from: dateComponents)
    }
}
