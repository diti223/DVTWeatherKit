//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public final class WeatherViewModel: ObservableObject {
    @Published public private(set) var currentWeather = PresentationWeather.placeholder
    @Published public var errorMessage: String?
    
    public var currentTemperature: String {
        currentWeather.temperature
    }

    public var currentCondition: WeatherCondition {
        currentWeather.condition
    }
    
    public var currentConditionName: String {
        currentWeather.conditionName
    }
    
    public var minTemperature: String {
        currentWeather.minTemperature
    }
    
    public var maxTemperature: String {
        currentWeather.maxTemperature
    }
    
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
        do {
            let extremesWeather = try await fetchWeatherUseCase.fetch()
            self.currentWeather = PresentationWeather(extremesWeather: extremesWeather)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}


extension PresentationWeather {
    static let placeholder = PresentationWeather(
        temperature: "-°",
        condition: .sunny,
        minTemperature: "-°",
        maxTemperature: "-°"
    )
    
    init(extremesWeather: ExtremesWeather) {
        self.init(
            temperature: "\(extremesWeather.weather.temperature)°",
            condition: extremesWeather.weather.condition,
            minTemperature: "\(extremesWeather.minTemperature)°",
            maxTemperature: "\(extremesWeather.maxTemperature)°"
        )
    }
}
