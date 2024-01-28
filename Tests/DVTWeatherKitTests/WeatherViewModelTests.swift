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
        XCTAssertEqual(sut.currentCondition, nil)
        XCTAssertEqual(sut.minTemperature, "-°")
        XCTAssertEqual(sut.maxTemperature, "-°")
    }
    
    func testOnAppearFetchesCurrentWeather() async {
        let givenWeather = [
            Weather(temperature: -20, condition: .sunny),
            Weather(temperature: 0, condition: .raining),
            Weather(temperature: 32, condition: .cloudy)
        ]
        
        let expectedWeather = [
            (temperature: "-20°", condition: "Sunny"),
            (temperature: "0°", condition: "Rainy"),
            (temperature: "32°", condition: "Cloudy")
        ]
        
        for (given, expected) in zip(givenWeather, expectedWeather) {
            
            let stub = FetchWeatherUseCaseStub(result: given)
            let sut = makeSUT(fetchWeatherUseCase: stub)
            
            await sut.viewDidAppear()
            
            XCTAssertEqual(sut.currentTemperature, expected.temperature)
            XCTAssertEqual(sut.currentCondition, expected.condition)
        }
    }
    
    //MARK: - Private Helper
    private func makeSUT(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchWeatherUseCase: FetchWeatherUseCase = FetchWeatherUseCaseStub(result: Weather(temperature: -300, condition: .sunny))
    ) -> WeatherViewModel {
        WeatherViewModel(
            calendar: calendar,
            date: date,
            fetchWeatherUseCase: fetchWeatherUseCase
        )
    }
    
}


struct FetchWeatherUseCaseStub: FetchWeatherUseCase {
    let result: Weather
    func fetch() -> Weather {
        result
    }
}

