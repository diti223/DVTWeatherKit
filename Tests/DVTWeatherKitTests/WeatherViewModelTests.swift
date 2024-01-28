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
    
    func testOnAppearFetchesCurrentWeather() async {
        let givenTemperatures: [Celsius] = [-20, 0, 32]
        
        for givenTemperature in givenTemperatures {
            
            let stub = FetchWeatherUseCaseStub(result: givenTemperature)
            let sut = makeSUT(fetchWeatherUseCase: stub)
            
            await sut.viewDidAppear()
            
            let actualTemperature = sut.currentTemperature
            let expectedTemperature = "\(givenTemperature)°"
            XCTAssertEqual(actualTemperature, expectedTemperature)
        }
    }
    
    //MARK: - Private Helper
    private func makeSUT(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchWeatherUseCase: FetchWeatherUseCase = FetchWeatherUseCaseStub(result: 0)
    ) -> WeatherViewModel {
        WeatherViewModel(
            calendar: calendar,
            date: date,
            fetchWeatherUseCase: fetchWeatherUseCase
        )
    }
    
}


struct FetchWeatherUseCaseStub: FetchWeatherUseCase {
    let result: Celsius
    func fetch() -> Celsius {
        result
    }
}

