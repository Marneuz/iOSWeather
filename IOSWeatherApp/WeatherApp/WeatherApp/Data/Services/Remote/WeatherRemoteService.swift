//
//  WeatherRemoteService.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation

protocol WeatherRemoteService {
    func getWeatherForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast 
}
