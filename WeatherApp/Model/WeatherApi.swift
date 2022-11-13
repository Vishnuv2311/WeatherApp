//
//  Weather.swift
//  WeatherApp
//
//  Created by Vishnu V on 12/11/22.
//

import Foundation


class WeatherApi{
   
    static  let API_KEY   = "4961eff22443714996e665cb0efde3b8"
    
    
    enum Endpoints{
        static  let OpenWeatherMapURL = "https://api.openweathermap.org"
        static  let OpenWeatherMapImageURL = "https://openweathermap.org"
        
        case getCityWeather(String)
        
        case getLocationWeather(Double, Double)
        
        var url :URL{
            
            switch self {
                
            case .getLocationWeather(let latitude, let longitude):
                var urlComps = URLComponents(string: Endpoints.OpenWeatherMapURL + "/data/2.5/onecall")
                let queryParams = [
                    URLQueryItem(name: "lat", value: "\(latitude)"),
                    URLQueryItem(name: "lon", value: "\(longitude)"),
                    URLQueryItem(name: "exclude", value: "minutely,daily"),
                    URLQueryItem(name: "appid", value: API_KEY)
                ]
                urlComps?.queryItems = queryParams
                let result = urlComps?.url?.absoluteString ?? ""
                let url = URL(string: result)!
                return url
                
            case .getCityWeather(let cityName):
                var urlComps = URLComponents(string: Endpoints.OpenWeatherMapURL + "/data/2.5/onecall")
                let queryParams = [
                    URLQueryItem(name: "q", value: cityName),
                    URLQueryItem(name: "appid", value: API_KEY),
                    URLQueryItem(name: "units", value: "metric"),
                ]
                urlComps?.queryItems = queryParams
                let result = urlComps?.url?.absoluteString ?? ""
                let url = URL(string: result)!
                return url
                
                
                
                
            }
        }
    }
        
        class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
             }
            
            task.resume()
            
            return task
        }
    
    
    class func getLocationWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?, Error?) -> Void) -> Void {
        let url = Endpoints.getLocationWeather(latitude, longitude).url
        
        taskForGETRequest(url: url, responseType: WeatherResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
        
        
    }

    
    
    
   

    
    func  getWeatherIcon(condition:Int) -> String{
      if (condition < 300) {
        return "🌩"
      } else if (condition < 400) {
        return "🌧"
      } else if (condition < 600) {
        return "☔️";
      } else if (condition < 700) {
          return "☃️"
      } else if (condition < 800) {
          return "🌫"
      } else if (condition == 800) {
          return "☀️"
      } else if (condition <= 804) {
          return "☁️"
      } else {
          return "🤷‍"
      }
    }
    
    func getMessage( temp:Int) ->String{
      if (temp > 25) {
          return "It's 🍦 time"
      } else if (temp > 20) {
          return "Time for shorts and 👕"
      } else if (temp < 10) {
          return "You'll need 🧣 and 🧤"
      } else {
          return "Bring a 🧥 just in case"
      }
    }

}

