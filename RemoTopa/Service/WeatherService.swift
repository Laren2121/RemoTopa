//
//  WeatherService.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-28.
//

import Foundation

class WeatherService {
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey: String
    
    init() {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["OpenWeatherAPIKey"] as? String {
            self.apiKey = key
        } else {
            fatalError("API key not found. Please add a Secrets.plist file to your project and add the OpenWeatherAPIKey key to it.")
        }
    }
    
    func fetchWeather(for cityName: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let urlString = "\(baseURL)?q=\(cityName)&appid=\(apiKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
            completion(.failure(WeatherError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                    return
                }
            } else {
                completion(.failure(WeatherError.noData))
            }
            
        }
        task.resume()
        
    }
    
    enum WeatherError: Error {
        case invalidURL
        case noData
    }
}
