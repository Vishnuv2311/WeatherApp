//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Vishnu V on 12/11/22.
//

import Foundation


struct WeatherResponse : Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentForecast
    let hourly: [HourlyForecast]
}

struct CurrentForecast: Codable {
    let dt: Date?
    let sunrise: Date?
    let sunset: Date?
    let temp: Double
    let humidity: Int
    let weather: [WeatherObject]
    let snow: SnowObject?
}

struct HourlyForecast: Codable {
    let dt: Date
    let temp: Double
    let humidity: Int
    let weather: [WeatherObject]
    let snow: SnowObject?
}

struct WeatherObject: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct SnowObject: Codable {
    let oneHour: Double
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
