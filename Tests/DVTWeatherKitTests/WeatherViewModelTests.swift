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
}

final class WeatherViewModelTests {
    func testOnInit() {
        let sut = WeatherViewModel()
        XCTAssertEqual(sut.currentTemperature, "-°")
        XCTAssertEqual(sut.minTemperature, "-°")
        XCTAssertEqual(sut.maxTemperature, "-°")
    }
}
