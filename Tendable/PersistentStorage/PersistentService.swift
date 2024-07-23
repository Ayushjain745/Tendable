//
//  PersistentService.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    private let userDefaults = UserDefaults.standard
    private let inspectionsKey = "completedInspections"
    
    private init() {}
    
    func saveInspection(_ inspection: Inspection) {
        var inspections = fetchInspections()
        inspections.append(inspection)
        if let encoded = try? JSONEncoder().encode(inspections) {
            userDefaults.set(encoded, forKey: inspectionsKey)
        }
    }
    
    func fetchInspections() -> [Inspection] {
        if let data = userDefaults.data(forKey: inspectionsKey),
           let inspections = try? JSONDecoder().decode([Inspection].self, from: data) {
            return inspections
        }
        return []
    }
}
