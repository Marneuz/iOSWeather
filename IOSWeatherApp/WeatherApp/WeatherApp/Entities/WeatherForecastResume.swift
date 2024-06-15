//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.


import Foundation

struct WeatherForecastResume: Decodable {
    let temperature: Double
    let isDay: Int
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case isDay = "is_day"
        case weatherCode = "weather_code"
    }
    
    static var example: WeatherForecastResume{
        .init(temperature: 25, isDay: 1, weatherCode: 99)
    }
}


// MARK: - Welcome
struct WeatherForecast: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current
    let minutely15_Units: Minutely15_Units
    let minutely15: Minutely15

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
        case minutely15_Units = "minutely_15_units"
        case minutely15 = "minutely_15"
    }
    
    static var example: WeatherForecastResume{
        .init(temperature: 25, isDay: 1, weatherCode: 99)
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let isDay, weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case isDay = "is_day"
        case weatherCode = "weather_code"
    }
}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    var time, interval, temperature2M, isDay: String
    let weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case isDay = "is_day"
        case weatherCode = "weather_code"
    }
}

// MARK: - Minutely15
struct Minutely15: Codable {
    let time: [String]
    let weatherCode: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
    }
}

// MARK: - Minutely15_Units
struct Minutely15_Units: Codable {
    let time, weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
    }
}
