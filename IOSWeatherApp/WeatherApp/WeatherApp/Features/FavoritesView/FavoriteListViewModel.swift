//
//  FavoritesViewModel.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import Foundation
import Combine

class FavoriteListViewModel: ObservableObject {
    @Published var favoriteLocations: [FavoriteLocation] = []
    @Published var weatherForecasts: [String: WeatherForecast] = [:]

    private let loadFavoritesUseCase: LoadFavoritesUseCase
    private let deleteFavoriteUseCase: DeleteFavoriteUseCase
    private let weatherForecastUseCase: WeatherForecastUseCase

    private var cancellables = Set<AnyCancellable>()

    init(loadFavoritesUseCase: LoadFavoritesUseCase, deleteFavoriteUseCase: DeleteFavoriteUseCase, weatherForecastUseCase: WeatherForecastUseCase) {
        self.loadFavoritesUseCase = loadFavoritesUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.weatherForecastUseCase = weatherForecastUseCase
        loadFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: .didAddFavorite, object: nil)
    }
    @objc private func favoritesUpdated() {
        loadFavorites()
    }

    func loadFavorites() {
        Task {
            do {
                self.favoriteLocations = try await loadFavoritesUseCase.execute()
                for location in favoriteLocations {
                    if let name = location.name {
                        let forecast = try await weatherForecastUseCase.execute(latitude: location.latitude, longitude: location.longitude)
                        DispatchQueue.main.async {
                            print(forecast)
                            self.weatherForecasts[name] = forecast
                        }
                    }
                }
            } catch {
                print("Error loading favorites: \(error)")
            }
        }
    }

    func deleteFavorite(_ location: FavoriteLocation) {
        Task {
            do {
                try await deleteFavoriteUseCase.execute(favorite: location)
                DispatchQueue.main.async {
                    if let index = self.favoriteLocations.firstIndex(where: { $0.id == location.id }) {
                        self.favoriteLocations.remove(at: index)
                        self.weatherForecasts.removeValue(forKey: location.name ?? "")
                    }
                }            } catch {
                print("Error deleting favorite: \(error)")
            }
        }
    }
}
