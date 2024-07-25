//
//  AnswerChoiceView.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import SwiftUI

struct AnswerChoiceView: View {
    @ObservedObject var viewModel: InspectionDetailViewModel
    let categoryIndex: Int
    let questionIndex: Int
    let isReadOnly: Bool
    
    var body: some View {
        List(viewModel.inspection.survey.categories[categoryIndex].questions[questionIndex].answerChoices) { choice in
            Button(action: {
                viewModel.updateSelectedAnswerChoice(for: questionIndex, inCategoryIndex: categoryIndex, with: choice.id)
            }) {
                HStack {
                    Text(choice.name)
                    if viewModel.inspection.survey.categories[categoryIndex].questions[questionIndex].selectedAnswerChoiceId == choice.id {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
            .disabled(isReadOnly)
        }
        .navigationTitle(isReadOnly ? "Selected Answer" : "Select Answer")
    }
}

