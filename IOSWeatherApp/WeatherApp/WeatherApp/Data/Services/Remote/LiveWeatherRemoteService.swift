//
//  LiveWeatherRemoteService.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//


import Foundation

class LiveWeatherRemoteService: WeatherRemoteService {
    private let networkClient: NetworkClient
    private let baseURL = "https://api.open-meteo.com/v1/forecast"

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getWeatherForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast{
        let queryParams: [String: String] = [
            "latitude": "\(latitude)",
            "longitude": "\(longitude)",
            "current": "temperature_2m,is_day,weather_code",
            "minutely_15": "weather_code"
        ]
        
        return try await networkClient.getCall(url: baseURL, queryParams: queryParams)
    }
}
