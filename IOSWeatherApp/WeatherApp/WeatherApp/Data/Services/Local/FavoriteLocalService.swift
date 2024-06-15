//
//  LocalWeatherService.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation

protocol FavoriteLocalService {
    
    func fetchFavoriteLocations() async throws -> [FavoriteLocation]
    
    func addFavorite(name: String, latitude: Double, longitude: Double) async throws
    
    func deleteFavorite(_ favoriteLocation: FavoriteLocation) async throws
}
