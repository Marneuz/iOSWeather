//
//  DeleteFavoriteUseCase.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import Foundation

class DeleteFavoriteUseCase {
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func execute(favorite: FavoriteLocation) async throws {
        try await weatherRepository.deleteFavorite(favorite)
    }
}
