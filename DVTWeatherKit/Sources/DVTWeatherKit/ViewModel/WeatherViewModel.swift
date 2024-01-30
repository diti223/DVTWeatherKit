//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public final class WeatherViewModel: ObservableObject {
    @Published public private(set) var currentWeather = PresentationWeather.placeholder
    public var currentTemperature: String {
        currentWeather.temperature
    }

    public var currentCondition: WeatherCondition {
        currentWeather.condition
    }
    
    public var currentConditionName: String {
        currentWeather.conditionName
    }
    
    public let minTemperature = "-°"
    public let maxTemperature = "-°"
    
    let fetchWeatherUseCase: FetchWeatherUseCase
    
    public init(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchWeatherUseCase: FetchWeatherUseCase
    ) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    @MainActor
    public func viewDidAppear() async {
        let weather = await fetchWeatherUseCase.fetch()
        self.currentWeather = PresentationWeather(weather: weather)
    }
}


extension PresentationWeather {
    static let placeholder = PresentationWeather(temperature: "-°", condition: .sunny)
    
    init(celsius: Celsius, condition: WeatherCondition) {
        self.init(
            temperature: "\(celsius)°",
            condition: condition
        )
    }
    
    init(weather: Weather) {
        self.init(
            celsius: weather.temperature,
            condition: weather.condition
        )
    }
}
