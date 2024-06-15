//
//  FavoriteCardView.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import SwiftUI

struct CardView: View {
    let location: FavoriteLocation
    let forecast: WeatherForecast
    let deleteAction: () -> Void
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        NavigationLink(destination: coordinator.makeWeatherDetailView(locationName: location.name ?? "Unknown", latitude: location.latitude, longitude: location.longitude)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(location.name ?? "Unknown")
                        .font(.headline)
                    HStack {
                        WeatherIconView(weatherCode: forecast.current.weatherCode, isDaytime: forecast.current.isDay == 1)
                        Text("\(forecast.current.temperature2M, specifier: "%.1f")°C")
                    }
                    WeatherCodeView(code: forecast.current.weatherCode)
                }
                Spacer()
                Button(action: deleteAction) {
                    Image(systemName: "trash")
                        .tint(Color.red)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
