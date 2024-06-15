//
//  Coordinator.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation

class Coordinator: ObservableObject {
    
    private let repository: WeatherRepository
    
    private let forecastUseCase: WeatherForecastUseCase
    private let loadFavoritesUseCase: LoadFavoritesUseCase
    private let deleteFavoritesUseCase: DeleteFavoriteUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase
    
    init(mock: Bool = false) {
        let networkClient = URLSessionNetworkClient()
        let persistenceController = CoreDataPersistentController()
        
        let remoteService: WeatherRemoteService = mock ? MockWeatherRemoteService(): LiveWeatherRemoteService(networkClient: networkClient)
        let localService: FavoriteLocalService = mock ?
        MockFavoriteLocalService():
        CoreDataFavoriteService(container: persistenceController.container)
        
        repository = WeatherRepository(remoteService: remoteService, favoriteService: localService)
        
        forecastUseCase = WeatherForecastUseCase(weatherRepository: repository)
        loadFavoritesUseCase = LoadFavoritesUseCase(weatherRepository: repository)
        deleteFavoritesUseCase = DeleteFavoriteUseCase(weatherRepository: repository)
        addFavoriteUseCase = AddFavoriteUseCase(weatherRepository: repository)
    }
    
    // Método para crear WeatherView
    @MainActor func makeWeatherView() -> WeatherView {
        let viewModel = WeatherViewModel(weatherForecastUseCase: forecastUseCase)
        return WeatherView(viewModel: viewModel)
    }
    
    // Método para crear WeatherDetailView
    @MainActor func makeWeatherDetailView(locationName: String, latitude: Double, longitude: Double) -> WeatherDetailView {
        let viewModel = WeatherDetailViewModel(addFavoriteUseCase: addFavoriteUseCase, forecastUseCase: forecastUseCase)
        viewModel.loadData(forLocationName: locationName, latitude: latitude, longitude: longitude)
        return WeatherDetailView(viewModel: viewModel)
    }
    
    // Método para crear FavoriteListView
    @MainActor func makeFavoriteListView() -> FavoriteListView {
         let viewModel = FavoriteListViewModel(loadFavoritesUseCase: loadFavoritesUseCase, deleteFavoriteUseCase: deleteFavoritesUseCase, weatherForecastUseCase: forecastUseCase)
         return FavoriteListView(viewModel: viewModel)
     }

}

