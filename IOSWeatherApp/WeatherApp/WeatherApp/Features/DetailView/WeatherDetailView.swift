//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by user241563 on 24/11/23.

import SwiftUI

struct WeatherDetailView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: WeatherDetailViewModel

    init(viewModel: WeatherDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            GeometryReader { geo in
                ZStack {
                
                    WeatherImageView(weatherCode: viewModel.weatherForecast?.current.weatherCode ?? 0, isDaytime: viewModel.isDaytime)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .edgesIgnoringSafeArea(.all)

                    Text(viewModel.locationName ?? "Unknown Location")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.bottom, geo.size.height / 2)
                }
            }
            .frame(height: 300)

            if let weatherForecast = viewModel.weatherForecast {
                Text("\(weatherForecast.current.temperature2M, specifier: "%.1f")°C")
                    .font(.system(size: 60))
                    .fontWeight(.bold)

                HStack(spacing: 16) {
                    WeatherIconView(weatherCode: weatherForecast.current.weatherCode, isDaytime: viewModel.isDaytime)
                    WeatherCodeView(code: weatherForecast.current.weatherCode)
                        .font(.title3)
                }
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    addFavorite()
                }) {
                    Text("Add to Favorites")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                .padding(.bottom,20)
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                ProgressView()
            }
        }
    }

    private func addFavorite() {
        if let latitude = viewModel.latitude, let longitude = viewModel.longitude, let locationName = viewModel.locationName {
            viewModel.addFavorite(name: locationName, latitude: latitude, longitude: longitude, temperature: viewModel.weatherForecast?.current.temperature2M ?? 0)
        }
    }
}
