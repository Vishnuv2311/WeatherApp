//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Vishnu V on 12/11/22.
//

import Foundation


struct WeatherResponse: Codable {
        let coord: Coord?
        let weather: [Weather]?
        let base: String?
        let main: Main
        let visibility: Int?
        let wind: Wind?
        let clouds: Clouds?
        let dt: Int?
        let sys: Sys?
        let timezone, id: Int?
        let name: String?
        let cod: Int?
    
    
    func  getWeatherIcon() -> String{
        if(weather?[0].id == nil){
            return "🤷‍"
        }
        else if (weather![0].id! < 300) {
        return "🌩"
      } else if (weather![0].id! < 400) {
        return "🌧"
      } else if (weather![0].id! < 600) {
        return "☔️";
      } else if (weather![0].id! < 700) {
          return "☃️"
      } else if (weather![0].id! < 800) {
          return "🌫"
      } else if (weather![0].id! == 800) {
          return "☀️"
      } else if (weather![0].id! <= 804) {
          return "☁️"
      } else {
          return "🤷‍"
      }
    }
    
    func getMessage() ->String{
      if (main.temp > 25) {
          return "It's 🍦 time"
      } else if (main.temp > 20) {
          return "Time for shorts and 👕"
      } else if (main.temp < 10) {
          return "You'll need 🧣 and 🧤"
      } else {
          return "Bring a 🧥 just in case"
      }
    }
    }

    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int?
    }

    // MARK: - Coord
    struct Coord: Codable {
        let lon, lat: Double?
    }

    // MARK: - Main
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
        }
    }

    // MARK: - Sys
    struct Sys: Codable {
        let type, id: Int?
        let country: String?
        let sunrise, sunset: Int?
    }

    // MARK: - Weather
    struct Weather: Codable {
        let id: Int?
        let main, weatherDescription, icon: String?

        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }

    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
