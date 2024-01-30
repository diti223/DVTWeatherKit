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
        XCTAssertEqual(sut.currentCondition, .sunny)
        XCTAssertEqual(sut.minTemperature, "-°")
        XCTAssertEqual(sut.maxTemperature, "-°")
    }
    
    func testOnAppearFetchesCurrentWeather() async {
        let givenWeather = [
            Weather(temperature: -20, condition: .sunny),
            Weather(temperature: 0, condition: .rainy),
            Weather(temperature: 32, condition: .cloudy)
        ]
        
        let expectedWeather = [
            (
                temperature: "-20°",
                conditionName: "Sunny",
                condition: WeatherCondition.sunny
            ),
            (
                temperature: "0°",
                conditionName: "Rainy",
                condition: .rainy
            ),
            (
                temperature: "32°",
                conditionName: "Cloudy",
                condition: .cloudy
            )
        ]
        
        for (given, expected) in zip(givenWeather, expectedWeather) {
            
            let stub = FetchWeatherUseCaseStub(
                result: ExtremesWeather(
                    weather: given,
                    minTemperature: -10,
                    maxTemperature: 20
                )
            )
            let sut = makeSUT(fetchWeatherUseCase: stub)
            
            await sut.viewDidAppear()
            
            XCTAssertEqual(sut.currentTemperature, expected.temperature)
            XCTAssertEqual(sut.currentConditionName, expected.conditionName)
            XCTAssertEqual(sut.currentCondition, expected.condition)
            XCTAssertEqual(sut.maxTemperature, "20°")
            XCTAssertEqual(sut.minTemperature, "-10°")
        }
    }
    
    //MARK: - Private Helper
    private func makeSUT(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchWeatherUseCase: FetchWeatherUseCase = FetchWeatherUseCaseStub(result: .dummy)) -> WeatherViewModel {
            WeatherViewModel(
                calendar: calendar,
                date: date,
                fetchWeatherUseCase: fetchWeatherUseCase
            )
    }
    
}

extension ExtremesWeather {
    static let dummy = ExtremesWeather(
        weather: Weather(temperature: -300, condition: .sunny),
        minTemperature: 0,
        maxTemperature: 0
    )
}

struct FetchWeatherUseCaseStub: FetchWeatherUseCase {
    let result: ExtremesWeather
    func fetch() async throws -> DVTWeatherKit.ExtremesWeather {
        result
    }
}

