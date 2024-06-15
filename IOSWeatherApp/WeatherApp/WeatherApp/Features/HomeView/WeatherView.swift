//
//  HomeView.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: WeatherViewModel
    @State private var showDetail = false

    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.locationName ?? "Unknown Location")
                    .font(.title)
                if let weatherForecast = viewModel.weatherForecast {
                    NavigationLink(destination: {
                        coordinator.makeWeatherDetailView(locationName: viewModel.locationName ?? "Unknown", latitude: weatherForecast.latitude, longitude: weatherForecast.longitude)
                    }) {
                        VStack {
                            Text("\(weatherForecast.current.temperature2M, specifier: "%.1f")°C")
                                .font(.largeTitle)
                            
                            WeatherIconView(weatherCode: weatherForecast.current.weatherCode, isDaytime: viewModel.isDaytime)
                            
                            WeatherCodeView(code: weatherForecast.current.weatherCode)
                        }
                    }
                } else {
                    Text("Loading weather data...")
                }
            }
            .onAppear {
                viewModel.requestLocationAndUpdateWeather()
            }
        }
    }
}
