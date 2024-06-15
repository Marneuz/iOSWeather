//
//  MockRemoteService.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation

struct MockWeatherRemoteService: WeatherRemoteService{
    
    func getWeatherForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast{       
        return .init(latitude: 123, longitude: 123, generationtimeMS: 123, utcOffsetSeconds: 1, timezone: "", timezoneAbbreviation: "12", elevation: 1, currentUnits: CurrentUnits(time: "12", interval: "12", temperature2M: "12", isDay: "12", weatherCode: "12"), current: Current(time: "12", interval: 1, temperature2M: 12.1, isDay: 1, weatherCode: 1), minutely15_Units: Minutely15_Units(time: "12", weatherCode: "12"), minutely15: Minutely15(time: ["12"], weatherCode: [1]))
    }
}
