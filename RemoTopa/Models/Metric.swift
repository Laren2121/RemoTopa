//
//  MetricType.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-28.
//
import Foundation

enum MetricType {
    case percentage
    case price
}

struct Metric: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let type: MetricType
}
