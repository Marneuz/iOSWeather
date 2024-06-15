//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation


@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherForecast: WeatherForecast?
    @Published var locationName: String?
    @Published var error: Error?
    
    var isDaytime: Bool {
        
        weatherForecast?.current.isDay == 1
    }

    private let locationManager = LocationManager()
    private let forecastUseCase: WeatherForecastUseCase
    
    init(weatherForecastUseCase: WeatherForecastUseCase) {
        self.forecastUseCase = weatherForecastUseCase
        requestLocationAndUpdateWeather()
    }
   
    func requestLocationAndUpdateWeather() {
        locationManager.requestLocationPermission()
        locationManager.onLocationUpdate = { [weak self] location, locationName in
            self?.locationName = locationName
            self?.fetchWeatherForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        locationManager.onLocationError = { [weak self] error in
            self?.error = error
        }
    }

    func fetchWeatherForecast(latitude: Double, longitude: Double) {
        Task {
            do {
                let forecast = try await forecastUseCase.execute(latitude: latitude, longitude: longitude)
             
                self.weatherForecast = forecast
            } catch {
               
                self.error = error
                
            }
        }
    }
}
