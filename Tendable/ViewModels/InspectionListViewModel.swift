//
//  InspectionListViewModel.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import Foundation
import SwiftUI

class InspectionListViewModel: ObservableObject {
    @Published var inspections: [Inspection] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchInspections() {
        isLoading = true
        APIService.shared.startInspection { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let inspection):
                    self.inspections = [inspection]  // Assuming you want to display the single inspection
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


