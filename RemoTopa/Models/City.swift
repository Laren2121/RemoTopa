//
//  City.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.

import Foundation

struct City: Identifiable, Decodable {
    let id: UUID
    let name: String
    let imageName: String
    var weather: String?
    var costOfRent: String?
    var internetSpeed: String?
    var lifestyle: String?
    var datingScene: String?
    var events: [String]?
    var placesToVisit: [String]?
}
