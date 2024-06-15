//
//  WeatherCodeView.swift
//  WeatherApp
//
//  Created by user241563 on 24/11/23.
//

import SwiftUI

struct WeatherCodeView: View {
    let code: Int

    var body: some View {
        Text(weatherDescription(for: code))
    }

    //Mapper para mostrar los String localizables en la view, usando el codigo que traigo del weathercode
    private func weatherDescription(for code: Int) -> LocalizedStringKey {
        let key: String
        switch code {
        case 0: key = "clear.sky"
        case 1: key = "mainly.clear"
        case 2: key = "partly.cloudy"
        case 3: key = "overcast"
        case 45: key = "fog"
        case 48: key = "depositing.rime.fog"
        case 51...55: key = "drizzle"
        case 56, 57: key = "freezing.drizzle"
        case 61: key = "slight.rain"
        case 63: key = "moderate.rain"
        case 65: key = "heavy.rain"
        case 66: key = "light.freezing.rain"
        case 67: key = "heavy.freezing.rain"
        case 71: key = "slight.snow.fall"
        case 73: key = "moderate.snow.fall"
        case 75: key = "heavy.snow.fall"
        case 77: key = "snow.grains"
        case 80: key = "slight.rain.showers"
        case 81: key = "moderate.rain.showers"
        case 82: key = "violent.rain.showers"
        case 85: key = "slight.snow.showers"
        case 86: key = "heavy.snow.showers"
        case 95: key = "thunderstorms"
        case 96: key = "thunderstorms.with.slight.hail"
        case 99: key = "thunderstorms.with.heavy.hail"
        default: key = "default"
        }
        return LocalizedStringKey(key)
    }

}
