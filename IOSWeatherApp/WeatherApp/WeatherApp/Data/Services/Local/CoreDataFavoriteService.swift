//
//  CoreDataWeatherService.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation
import CoreData

class CoreDataFavoriteService: FavoriteLocalService {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
    }

    func fetchFavoriteLocations() async throws -> [FavoriteLocation] {
        let request: NSFetchRequest<FavoriteLocation> = FavoriteLocation.fetchRequest()
        let context = container.viewContext
        return try context.fetch(request)
    }

    func addFavorite(name: String, latitude: Double, longitude: Double) async throws {
        let context = container.viewContext
        let favoriteLocation = FavoriteLocation(context: context)
        favoriteLocation.name = name
        favoriteLocation.latitude = latitude
        favoriteLocation.longitude = longitude
        

        try context.save()
    }

    func deleteFavorite(_ favoriteLocation: FavoriteLocation) async throws {
        let context = container.viewContext
        context.delete(favoriteLocation)
        try context.save()
    }
}
