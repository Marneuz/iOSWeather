//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation
import CoreLocation

class WeatherRepository {
    private let remoteService: WeatherRemoteService
    private let favoriteService: FavoriteLocalService
  
    init(remoteService: WeatherRemoteService, favoriteService: FavoriteLocalService) {
        self.remoteService = remoteService
        self.favoriteService = favoriteService

    }
    
    // Método para obtener el pronóstico del clima desde el servicio remoto
    func getWeatherForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast{
        return try await remoteService.getWeatherForecast(latitude: latitude, longitude: longitude)
    }
    
    // Metodos para manejas coredata
    func getFavoriteLocations() async throws -> [FavoriteLocation] {
        try await favoriteService.fetchFavoriteLocations()
    }
    
    func addFavorite(name: String, latitude: Double, longitude: Double) async throws {
        try await favoriteService.addFavorite(name: name, latitude: latitude, longitude: longitude)
    }
    
    func deleteFavorite(_ favorite: FavoriteLocation) async throws {
        try await favoriteService.deleteFavorite(favorite)
    }
}
