//
//  ContentView.swift
//  WeatherApp
//
//  Created by user241563 on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        TabView{
            coordinator.makeWeatherView()
                .tabItem { Label("Current Weather", systemImage: "cloud.sun.rain.circle")
                }
            
            coordinator.makeFavoriteListView()
                .tabItem {
                    Label("Favorite Location", systemImage: "star.fill")
                }
        }
    }
}
