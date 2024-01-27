//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import XCTest

struct WeatherViewModel {
    let currentTemperature = "-°"
    let minTemperature = "-°"
    let maxTemperature = "-°"
    
    let forecastDays: [String]
    
    init(calendar: Calendar = .current, date: Date = Date()) {
        let currentWeekday = calendar.dateComponents([.weekday], from: date).weekday!
        
        let weekdaySymbolIndex = currentWeekday - 1

        forecastDays = (1...5).map { offset in
            calendar.weekdaySymbols[(weekdaySymbolIndex + offset) % 7]
        }
    }
}

final class WeatherViewModelTests: XCTestCase {
    func testOnInit() {
        let sut = WeatherViewModel()
        XCTAssertEqual(sut.currentTemperature, "-°")
        XCTAssertEqual(sut.minTemperature, "-°")
        XCTAssertEqual(sut.maxTemperature, "-°")
        
    }
    
    func testOnInitPresentForecastDays() {
        let calendar = Calendar(identifier: .gregorian)
        let mondayDate = Date.make(calendar: calendar, year: 2024, month: 1, day: 29)!
        XCTAssertEqual(
            WeatherViewModel(calendar: calendar, date: mondayDate).forecastDays,
            ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        )
        
        let fridayDate = Date.make(calendar: calendar, year: 2024, month: 2, day: 2)!
        XCTAssertEqual(
            WeatherViewModel(calendar: calendar, date: fridayDate).forecastDays,
            ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"]
        )
    }
    
}

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
