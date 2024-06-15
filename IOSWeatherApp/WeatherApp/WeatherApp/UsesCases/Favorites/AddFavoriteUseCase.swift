//
//  AddFavoriteUseCase.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import Foundation

class AddFavoriteUseCase {
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func execute(name: String, latitude: Double, longitude: Double) async throws {
        try await weatherRepository.addFavorite(name: name, latitude: latitude, longitude: longitude)
    }
}
