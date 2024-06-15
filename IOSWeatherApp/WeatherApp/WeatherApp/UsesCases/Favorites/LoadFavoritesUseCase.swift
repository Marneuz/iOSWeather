//
//  LoadFavoritesUseCase.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import Foundation

class LoadFavoritesUseCase {
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func execute() async throws -> [FavoriteLocation] {
        try await weatherRepository.getFavoriteLocations()
    }
}
