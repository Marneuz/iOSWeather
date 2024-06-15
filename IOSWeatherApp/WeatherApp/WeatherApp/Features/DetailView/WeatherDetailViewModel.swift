//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by user241563 on 24/11/23.
//

import Foundation

class WeatherDetailViewModel: ObservableObject {
    @Published var weatherForecast: WeatherForecast?
    @Published var error: Error?
    @Published var locationName: String?
    
    private let addFavoriteUseCase: AddFavoriteUseCase
    private let forecastUseCase: WeatherForecastUseCase
    
    var latitude: Double?
    var longitude: Double?
    var isDaytime: Bool {
        weatherForecast?.current.isDay == 1
    }
    
    init( addFavoriteUseCase: AddFavoriteUseCase, forecastUseCase:WeatherForecastUseCase) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.forecastUseCase = forecastUseCase
    }
    
    @MainActor
    func fetchWeatherForecast(latitude: Double, longitude: Double) {
        Task {
            do {
                let forecast = try await forecastUseCase.execute(latitude: latitude, longitude: longitude)
                DispatchQueue.main.async {
                    
                    self.weatherForecast = forecast
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
    @MainActor
    func loadData(forLocationName name: String, latitude: Double, longitude: Double) {
        self.locationName = name
        self.latitude = latitude
        self.longitude = longitude
        fetchWeatherForecast(latitude: latitude, longitude: longitude)
    }
    
    @MainActor
    func addFavorite(name: String, latitude: Double, longitude: Double, temperature: Double) {
        Task {
            do {
                try await addFavoriteUseCase.execute(name: name, latitude: latitude, longitude: longitude)
                NotificationCenter.default.post(name: .didAddFavorite, object: nil)
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
}
