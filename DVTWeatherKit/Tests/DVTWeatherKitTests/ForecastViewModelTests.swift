//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import XCTest
import DVTWeatherKit

final class ForecastViewModelTests: XCTestCase {
    func testOnInit() {
        let sut = makeSUT()
        XCTAssertEqual(sut.temperatures, [])
        XCTAssertEqual(sut.conditions, [])
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
    
    func testOnAppearFetchesForecastWeather() async {
        let givenTemperatures = [20, 23, 27, 28, 30]
        let givenConditions = [WeatherCondition.sunny, .cloudy, .rainy, .sunny, .cloudy]
        let givenForecast: Forecast = zip(givenTemperatures, givenConditions).map { temp, condition in
            Weather(temperature: temp, condition: condition)
        }
        let stub = FetchForecastUseCaseStub(
            result: givenForecast
        )
        let sut = makeSUT(fetchForecastUseCase: stub)
        
        await sut.viewDidAppear()
        let expectedTemperatures = givenForecast.map(\.temperature).map { "\($0)°" }
        XCTAssertEqual(sut.temperatures, expectedTemperatures)
        XCTAssertEqual(sut.conditions, givenConditions)
        
    }
    
    //MARK: - Private Helper
    private func makeSUT(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchForecastUseCase: FetchForecastUseCase = FetchForecastUseCaseStub(result: [])
    ) -> ForecastViewModel {
        ForecastViewModel(
            calendar: calendar,
            date: date,
            fetchForecastUseCase: fetchForecastUseCase
        )
    }    
}

struct FetchForecastUseCaseStub: FetchForecastUseCase {
    let result: Forecast
    func fetchForecast() -> Forecast {
        result
    }
}
