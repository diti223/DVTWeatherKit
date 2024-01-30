//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import SwiftUI

public struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    public init(
        viewModel: WeatherViewModel,
        forecastViewModel: ForecastViewModel
    ) {
        self.viewModel = viewModel
        self.forecastViewModel = forecastViewModel
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Image(condition: viewModel.currentCondition)
                    .resizable()
                    .scaledToFit()
                currentWeather
            }
            ZStack {
                Color(condition: viewModel.currentCondition)
                VStack {
                    extremesView
                        .foregroundStyle(Color.white)
                    forecastView
                }
                .padding(.horizontal, 12)
                .padding(8)
                .font(.body.bold())
            }
            
        }
        .ignoresSafeArea()
        .alert(
            "Error",
            isPresented: $viewModel.hasError,
            presenting: viewModel.errorMessage, actions: { error in
                Button(action: {
                    viewModel.hasError = false
                }, label: {
                    Text("OK")
                })
            }, message: { errorMessage in
                Text(errorMessage)
            }
        )
        
    }
    
    private var extremesView: some View {
        ZStack {
            HStack {
                VStack {
                    Text(viewModel.minTemperature)
                    Text("min")
                }
                Spacer()
                VStack {
                    Text(viewModel.maxTemperature)
                    Text("max")
                }
            }
            VStack {
                Text(viewModel.currentTemperature)
                Text("Current")
            }
        }
    }
    
    private var forecastView: some View {
        ForecastView(
            viewModel: forecastViewModel
        )
    }
    
    private var currentWeather: some View {
        VStack {
            Text(viewModel.currentTemperature)
                .font(.system(size: 80))
                .padding(.leading, 12)
            Text(viewModel.currentConditionName.uppercased())
        }
        .frame(maxWidth: .infinity)
        .task {
            await viewModel.viewDidAppear()
        }
        .foregroundStyle(Color.white)
        .font(.largeTitle.bold())
        .padding(.bottom, 24)
        
    }
}

extension Image {
    private static func makeImageName(condition: WeatherCondition) -> String {
        switch condition {
            case .sunny:
                "forest_sunny"
            case .cloudy:
                "forest_cloudy"
            case .rainy:
                "forest_rainy"
        }
    }
    
    init(condition: WeatherCondition) {
        let name = Self.makeImageName(condition: condition)
        self = Image(ImageResource(name: name, bundle: Bundle.module))
    }
}

extension WeatherViewModel {
    var hasError: Bool {
        get { errorMessage != nil }
        set { errorMessage = nil }
    }
}

#Preview("Sunny") {
    WeatherView(
        viewModel: WeatherViewModel(
            fetchWeatherUseCase: PreviewFetchWeatherUseCase(weather: .sunny, delay: 2)
        ),
        forecastViewModel: ForecastViewModel(fetchForecastUseCase: PreviewFetchForecastUseCase())
    )
}

#Preview("Cloudy") {
    WeatherView(
        viewModel: WeatherViewModel(
            fetchWeatherUseCase: PreviewFetchWeatherUseCase(weather: .cloudy)
        ),
        forecastViewModel: ForecastViewModel(fetchForecastUseCase: PreviewFetchForecastUseCase())
    )
}

#Preview("Rainy") {
    WeatherView(
        viewModel: WeatherViewModel(
            fetchWeatherUseCase: PreviewFetchWeatherUseCase(weather: .rainy)
        ),
        forecastViewModel: ForecastViewModel(fetchForecastUseCase: PreviewFetchForecastUseCase())
    )
}

extension Weather {
    static let sunny = Weather(temperature: 25, condition: .sunny)
    static let cloudy = Weather(temperature: -1, condition: .cloudy)
    static let rainy = Weather(temperature: 3, condition: .rainy)
}

struct PreviewFetchWeatherUseCase: FetchWeatherUseCase {
    let weather: Weather
    var delay: TimeInterval?
    func fetch() async throws -> ExtremesWeather {
        if let delay {
            try! await Task.sleep(for: .seconds(delay))
        }
        return ExtremesWeather(
            weather: weather,
            minTemperature: -1,
            maxTemperature: 35
        )
    }
}

struct PreviewFetchForecastUseCase: FetchForecastUseCase {
    func fetchForecast() -> Forecast {
        [.sunny, .rainy, .cloudy, .sunny, .rainy]
    }
}
