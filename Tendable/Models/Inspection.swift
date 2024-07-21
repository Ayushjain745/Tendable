//
//  Inspection.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import Foundation

struct InspectionContainer: Codable {
    let inspection: Inspection
}

struct InspectionType: Codable, Identifiable {
    let id: Int
    let name: String
    let access: String
}

struct Area: Codable, Identifiable {
    let id: Int
    let name: String
}

struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}

struct Question: Codable, Identifiable {
    let id: Int
    let name: String
    var answerChoices: [AnswerChoice]
    var selectedAnswerChoiceId: Int?
    
    func updated(withNewAnswerChoiceId newId: Int?) -> Question {
        var copy = self
        copy.selectedAnswerChoiceId = newId
        return copy
    }
}

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    var questions: [Question]
}

struct Survey: Codable, Identifiable {
    let id: Int
    var categories: [Category]
}

struct Inspection: Codable, Identifiable {
    let id: Int
    let inspectionType: InspectionType
    let area: Area
    var survey: Survey
}
