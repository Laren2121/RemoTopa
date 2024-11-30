//
//  CityViewModel.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import Foundation
import Combine

class CityViewModel: ObservableObject {
    @Published var cities: [City] = []
    private var cancellables = Set<AnyCancellable>()
}
