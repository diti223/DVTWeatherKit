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
        let givenForecast: Forecast = [20, 23, 27, 28, 30]
        let stub = FetchForecastUseCaseStub(
            result: givenForecast
        )
        let sut = makeSUT(fetchForecastUseCase: stub)
        
        await sut.viewDidAppear()
        let expectedTemperatures = givenForecast.map { "\($0)°" }
        XCTAssertEqual(sut.temperatures, expectedTemperatures)
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
    let result: [Celsius]
    func fetchForecast() -> [Celsius] {
        result
    }
}
