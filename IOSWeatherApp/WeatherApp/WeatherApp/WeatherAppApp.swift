//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by user241563 on 13/11/23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
