//
//  HistoryViewModel.swift
//  Tendable
//
//  Created by Ayush Jain on 23/07/24.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var inspections: [Inspection] = []
    @Published var showError: Bool = false
    @Published var errorMessage: String?

    func fetchHistory() {
        self.inspections = PersistenceService.shared.fetchInspections()
    }
}


