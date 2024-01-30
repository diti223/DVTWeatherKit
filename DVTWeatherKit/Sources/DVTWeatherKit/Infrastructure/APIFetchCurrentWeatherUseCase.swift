//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public struct APIFetchCurrentWeatherUseCase {
    public let httpClient: HTTPClient
    public let location: (latitude: Double, longitude: Double)
    
    public init(httpClient: HTTPClient, location: (latitude: Double, longitude: Double)) {
        self.httpClient = httpClient
        self.location = location
    }
    
    public func fetch() async throws -> ExtremesWeather {
        let queryItems = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        let request = HTTPRequest(
            method: .get,
            path: "data/2.5/weather",
            queryItems: queryItems
        )
        
        let response = try await httpClient.data(request)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let apiResponse = try jsonDecoder.decode(APIFetchCurrentWeatherResponse.self, from: response.body)
        return try apiResponse.toExtremesWeather()
    }
}

struct APIFetchCurrentWeatherResponse: Decodable {
    struct APIWeather: Decodable {
        let id: Int
    }
    struct Main: Decodable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
    }
    
    let weather: [APIWeather]
    let main: Main
    
    func toWeather() throws -> Weather {
        guard let weatherCode = weather.last?.id else {
            let errorContext = DecodingError.Context(codingPath: [], debugDescription: "Expected at least one weather condition but got none.")
            throw DecodingError.valueNotFound(String.self, errorContext)
        }
        
        let condition: WeatherCondition = {
            switch weatherCode {
                case 800:
                    return .sunny
                case 801...804:
                    return .cloudy
                case 200...599:
                    return .rainy
                default:
                    return .cloudy
            }
        }()
        
        let weather = Weather(temperature: Celsius(main.temp), condition: condition)
        return weather
    }
    
    func toExtremesWeather() throws -> ExtremesWeather {
        ExtremesWeather(
            weather: try toWeather(),
            minTemperature: Celsius(main.tempMin),
            maxTemperature: Celsius(main.tempMax)
        )
    }
}
