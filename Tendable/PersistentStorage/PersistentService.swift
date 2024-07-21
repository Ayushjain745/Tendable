//
//  PersistentService.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    
    private let fileManager = FileManager.default
    private let fileURL: URL
    
    private init() {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = documentsDirectory.appendingPathComponent("inspections.json")
    }
    
    func saveInspection(_ inspection: Inspection) {
        do {
            let data = try JSONEncoder().encode(inspection)
            try data.write(to: fileURL)
        } catch {
            print("Error saving inspection: \(error.localizedDescription)")
        }
    }
    
    func loadInspection() -> Inspection? {
        guard let data = try? Data(contentsOf: fileURL),
              let inspection = try? JSONDecoder().decode(Inspection.self, from: data) else {
            return nil
        }
        return inspection
    }
}
