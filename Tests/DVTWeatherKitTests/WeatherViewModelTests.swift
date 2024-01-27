//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import XCTest
import DVTWeatherKit

final class WeatherViewModelTests: XCTestCase {
    func testOnInit() {
        let sut = makeSUT()
        XCTAssertEqual(sut.currentTemperature, "-°")
        XCTAssertEqual(sut.minTemperature, "-°")
        XCTAssertEqual(sut.maxTemperature, "-°")
    }
    
    func testOnInitPresentForecastDays() {
        let calendar = Calendar(identifier: .gregorian)

        let mondayDate = Date.make(calendar: calendar, year: 2024, month: 1, day: 29)!
        XCTAssertEqual(
            makeSUT(calendar: calendar, date: mondayDate).forecastDays,
            ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        )
        
        let fridayDate = Date.make(calendar: calendar, year: 2024, month: 2, day: 2)!
        XCTAssertEqual(
            makeSUT(calendar: calendar, date: fridayDate).forecastDays,
            ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"]
        )
    }
    
    // on appear - fetches current weather - states: nil - loading - loaded current
    
    func testOnAppearFetchesCurrentWeather() async {
        let givenTemperatures = [-20, 0, 32]
        
        for givenTemperature in givenTemperatures {
            
            let stub = FetchWeatherUseCaseStub(result: givenTemperature)
            let sut = makeSUT(fetchWeatherUseCase: stub)
            
            await sut.viewDidAppear()
            
            let actualTemperature = sut.currentTemperature
            let expectedTemperature = "\(givenTemperature)°"
            XCTAssertEqual(actualTemperature, expectedTemperature)
        }
    }
    
    // on appear - fetches forecast data; states: nil - loading - loaded forecast
    
    
    //MARK: - Private Helper
    private func makeSUT(calendar: Calendar = .current, date: Date = Date(), fetchWeatherUseCase: FetchWeatherUseCase = FetchWeatherUseCaseStub(result: 0)) -> WeatherViewModel {
        WeatherViewModel(calendar: calendar, date: date, fetchWeatherUseCase: fetchWeatherUseCase)
    }
    
}

struct FetchWeatherUseCaseStub: FetchWeatherUseCase {
    let result: Celsius
    func fetch() -> Celsius {
        result
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
