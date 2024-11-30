//
//  CityStatistics.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-30.
//
import Foundation

struct CityStatistics: Identifiable {
    let id = UUID()
    let name: String // consider this as the name of the statstics (like quality of living, cost, ...etc)
    let value: Double
    let isPercentage: Bool
}
