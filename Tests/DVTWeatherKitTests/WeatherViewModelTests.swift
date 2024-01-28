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
            
            let stub = FetchWeatherUseCaseStub(result: Weather(temperature: givenTemperature, condition: .sunny))
            let sut = makeSUT(fetchWeatherUseCase: stub)
            
            await sut.viewDidAppear()
            
            let actualTemperature = sut.currentTemperature
            let expectedTemperature = "\(givenTemperature)°"
            XCTAssertEqual(actualTemperature, expectedTemperature)
            
            let actualCondition = sut.currentCondition
            let expectedCondition = "Sunny"
            XCTAssertEqual(actualCondition, expectedCondition)
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

