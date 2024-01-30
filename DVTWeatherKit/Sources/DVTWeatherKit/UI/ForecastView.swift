//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewModel: ForecastViewModel
    
    var body: some View {
        ZStack {
            Color.clear
                .task {
                    await viewModel.viewDidAppear()
                }
            
            VStack(alignment: .leading) {
                ForEach(Array(viewModel.forecast.enumerated()), id: \.0) { (index, weather) in
                    ZStack {
                        Group {
                            HStack(alignment: .center) {
                                Text(viewModel.forecastDays[index])
                                Spacer()
                                Text(viewModel.temperatures[index])
                            }
                            
                            Image.makeIcon(condition: weather.condition)
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        .padding(.horizontal, 12)
                        .padding(8)
                        .font(.body.bold())
                    }
                    .foregroundStyle(Color.white)
                }
                Spacer()
            }.padding(.top, 24)
        }
        
    }
}

extension Image {
    static func makeIcon(condition: WeatherCondition) -> Image {
        let name = switch condition {
        case .sunny:
            "clear"
        case .cloudy:
            "partlysunny"
        case .rainy:
            "rain"
        }
        return Image(
            ImageResource(
                name: name,
                bundle: Bundle.module
            )
        )
    }
}

#Preview {
    ForecastView(
        viewModel: ForecastViewModel(
            fetchForecastUseCase: PreviewFetchForecastUseCase()
        )
    )
    .background(Color.black)
}
