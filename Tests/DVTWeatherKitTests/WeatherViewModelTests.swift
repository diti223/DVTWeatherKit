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
    
    let forecastDays = ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    let date: Date
    
    init(date: Date = Date()) {
        self.date = date
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
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: 2024,
            month: 1,
            day: 29,
            hour: 1,
            minute: 1
        )
        let date = calendar.date(from: dateComponents)!
        
        XCTAssertEqual(
            WeatherViewModel(date: date).forecastDays,
            ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        )
    }
}
