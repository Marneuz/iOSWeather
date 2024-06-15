//
//  WeatherImageView.swift
//  WeatherApp
//
//  Created by user241563 on 28/11/23.
//

import SwiftUI

struct WeatherIconView: View {
    let weatherCode: Int
    let isDaytime: Bool
    
    var body: some View {
        Image(systemName: getWeatherResourceForCode(weatherCode, isDaytime: isDaytime))
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
    }
}

struct WeatherImageView: View {
    let weatherCode: Int
    let isDaytime: Bool
    
    var body: some View {
        Image(getWeatherResourceForCode(weatherCode, isDaytime: isDaytime))
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

//He creado este mapper con las imagenes con nombres de iconos de sf symbols, para evitar repetir codigo. No se si funciona, pero esa era la idea.
private func getWeatherResourceForCode(_ weatherCode: Int, isDaytime: Bool) -> String {
    let cloudy = Set([1, 2, 3])
    let foggy = Set([45, 48])
    let rainy = Set([51, 53, 55, 56, 57, 80, 81, 82])
    let thunderstorms = Set([61, 63, 65, 66, 67, 95, 96, 99])
    let snowy = Set([71, 73, 75, 77, 85, 86])
    
    if isDaytime {
        switch weatherCode {
        case 0: return "sun.max.fill"
        case let code where cloudy.contains(code): return "cloud.sun.fill"
        case let code where rainy.contains(code): return "sun.rain.fill"
        case let code where thunderstorms.contains(code): return "cloud.sun.bolt.fill"
        case let code where snowy.contains(code): return "sun.snow.fill"
        case let code where foggy.contains(code): return "cloud.fog.fill"
        default: return "Weather Code not found"
        }
    } else {
        switch weatherCode{
        case 0: return "moon.fill"
        case let code where cloudy.contains(code): return "cloud.moon.fill"
        case let code where rainy.contains(code): return "cloud.moon.rain.fill"
        case let code where thunderstorms.contains(code): return "cloud.moon.bolt.fill"
        case let code where snowy.contains(code): return "moon.dust.fill"
        case let code where foggy.contains(code): return "moon.haze.fill"
        default: return "Weather Code not found"
            
        }
    }
}

