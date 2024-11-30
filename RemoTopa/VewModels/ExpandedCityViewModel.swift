//
//  ExpandedCityViewModel.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-30.
//
import Foundation

class ExpandedCityViewModel: ObservableObject {
    @Published var statistics: [CityStatistics] = []
    @Published var isLoadingStatistics = false
    @Published var statisticsError: Error?

    private let statisticsService = CityStatisticsService()
    private var cityName: String

    init(cityName: String) {
        self.cityName = cityName
        fetchStatistics()
    }

    func fetchStatistics() {
        isLoadingStatistics = true
        statisticsError = nil

        statisticsService.fetchStatistics(for: cityName) { result in
            DispatchQueue.main.async {
                self.isLoadingStatistics = false
                switch result {
                case .success(let stats):
                    self.statistics = stats
                case .failure(let error):
                    self.statisticsError = error
                }
            }
        }
    }
}
