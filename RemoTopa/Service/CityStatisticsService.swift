//
//  CityStatisticsService.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-30.
//
import Foundation

class CityStatisticsService {
    func fetchStatistics(for cityName: String, completion: @escaping (Result<[CityStatistics], Error>) -> Void) {

        let workItem = DispatchWorkItem {

            let statistics = [
                CityStatistics(name: "Quality of Living", value: Double.random(in: 60...90), isPercentage: true),
                CityStatistics(name: "Cost of Living", value: Double.random(in: 40...80), isPercentage: true),
                CityStatistics(name: "Cost of Rent", value: Double.random(in: 500...2000), isPercentage: false),
                CityStatistics(name: "Safety", value: Double.random(in: 40...90), isPercentage: true),
                CityStatistics(name: "Internet Price", value: Double.random(in: 20...100), isPercentage: false),
                CityStatistics(name: "Nightlife", value: Double.random(in: 50...100), isPercentage: true),
                CityStatistics(name: "Events Happening", value: Double.random(in: 30...90), isPercentage: true),
                CityStatistics(name: "Dating Scene", value: Double.random(in: 50...100), isPercentage: true)
            ]
            completion(.success(statistics))
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: workItem)
    }
}
