//
//  InspectionDetailViewModel.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import Foundation
import SwiftUI

class InspectionDetailViewModel: ObservableObject {
    @Published var inspection: Inspection
    @Published var errorMessage: String?
    @Published var isSubmitting: Bool = false

    private let apiService: APIServiceProtocol

    init(inspection: Inspection, apiService: APIServiceProtocol = APIService.shared) {
        self.inspection = inspection
        self.apiService = apiService
    }

    func updateSelectedAnswerChoice(for questionIndex: Int, inCategoryIndex categoryIndex: Int, with answerChoiceId: Int) {
        var category = inspection.survey.categories[categoryIndex]
        var question = category.questions[questionIndex]
        question = question.updated(withNewAnswerChoiceId: answerChoiceId)
        category.questions[questionIndex] = question
        inspection.survey.categories[categoryIndex] = category
    }

    func submitInspection(completion: @escaping (Bool) -> Void) {
        isSubmitting = true
        apiService.submitInspection(inspection: inspection) { result in
            DispatchQueue.main.async {
                self.isSubmitting = false
                switch result {
                case .success:
                    self.errorMessage = nil
                    PersistenceService.shared.saveInspection(self.inspection)  // Save the inspection locally
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

