//
//  WeatherData.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-28.
//

import Foundation

struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}
