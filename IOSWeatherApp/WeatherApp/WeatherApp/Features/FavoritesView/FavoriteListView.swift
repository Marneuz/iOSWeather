//
//  FavoriteListView.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import SwiftUI

struct FavoriteListView: View {
    @ObservedObject  var viewModel: FavoriteListViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(viewModel: FavoriteListViewModel) {
          self.viewModel = viewModel
      }
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteLocations.compactMap { $0.name }, id: \.self) { locationName in
                
                    CardView(location: viewModel.favoriteLocations.first { $0.name == locationName }!,
                             forecast: viewModel.weatherForecasts[locationName]!,
                             deleteAction: {
                                if let location = viewModel.favoriteLocations.first(where: { $0.name == locationName }) {
                                    viewModel.deleteFavorite(location)
                                }
                             }
                    )
            }
            .navigationTitle("Favorite Cities")
        }
    }
}
