//
//  Weather.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-27.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let temperatureCelsius: Double
    let weatherType: String
}
