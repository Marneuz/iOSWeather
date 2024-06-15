//
//  MockLocationLocalService.swift
//  WeatherApp
//
//  Created by user241563 on 24/11/23.
//

import Foundation

struct MockFavoriteLocalService : FavoriteLocalService{
    func fetchFavoriteLocations() async throws -> [FavoriteLocation] {
        let location1 = FavoriteLocation()
        
        return [location1]
    }
    
    func addFavorite(name: String, latitude: Double, longitude: Double) async throws {
        print("locacion added")
    }
    
    func deleteFavorite(_ favoriteLocation: FavoriteLocation) async throws {
        print("location removed)")
    }
    
    
}
