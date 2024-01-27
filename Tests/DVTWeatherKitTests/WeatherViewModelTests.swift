//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import XCTest

typealias Celsius = Int

protocol FetchWeatherUseCase {
    func fetch() -> Celsius
}


class WeatherViewModel {
    static let weekdaySymbols = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var currentTemperature = "-°"
    let minTemperature = "-°"
    let maxTemperature = "-°"
    
    let forecastDays: [String]
    
    
    let fetchWeatherUseCase: FetchWeatherUseCase
    
    init(calendar: Calendar = .current, date: Date = Date(), fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        
        let currentWeekday = calendar.dateComponents([.weekday], from: date).weekday!
        let weekdaySymbolIndex = currentWeekday - 1
        forecastDays = (1...5).map { offset in
            Self.weekdaySymbols[(weekdaySymbolIndex + offset) % 7]
        }
    }
    
    func viewDidAppear() async {
        let temperature = fetchWeatherUseCase.fetch()
        currentTemperature = "\(temperature)°"
    }
}



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
        let givenTemperature = 32
        let stub = FetchWeatherUseCaseStub(result: givenTemperature)
        let sut = makeSUT(fetchWeatherUseCase: stub)
        
        await sut.viewDidAppear()
        
        let actualTemperature = sut.currentTemperature
        let expectedTemperature = "\(givenTemperature)°"
        XCTAssertEqual(actualTemperature, expectedTemperature)
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
