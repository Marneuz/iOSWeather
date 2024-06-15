//
//  WeatherForecastUseCase.swift
//  WeatherApp
//
//  Created by user241563 on 26/11/23.
//

import Foundation

class WeatherForecastUseCase {
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func execute(latitude: Double, longitude: Double) async throws -> WeatherForecast { 
        return try await weatherRepository.getWeatherForecast(latitude: latitude, longitude: longitude)
    }
}
