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
        
        case getCityWeather(String)
        
        case getLocationWeather(Double, Double)
        
        var url :URL{
            
            switch self {
                
            case .getLocationWeather(let latitude, let longitude):
                var urlComps = URLComponents(string: Endpoints.OpenWeatherMapURL + "/data/2.5/weather")
                let queryParams = [
                    URLQueryItem(name: "lat", value: "\(latitude)"),
                    URLQueryItem(name: "lon", value: "\(longitude)"),
                    URLQueryItem(name: "units", value: "metric"),
                    URLQueryItem(name: "appid", value: API_KEY)
                ]
                urlComps?.queryItems = queryParams
                let result = urlComps?.url?.absoluteString ?? ""
                let url = URL(string: result)!
                return url
                
            case .getCityWeather(let cityName):
                var urlComps = URLComponents(string: Endpoints.OpenWeatherMapURL + "/data/2.5/weather")
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
    
    class func getCityWeather(cityName:String, completion: @escaping (WeatherResponse?, Error?) -> Void) -> Void {
        let url = Endpoints.getCityWeather(cityName).url
        
        taskForGETRequest(url: url, responseType: WeatherResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
        
        
    }

    
    
    
   

    




