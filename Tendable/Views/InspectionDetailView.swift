//
//  InspectionDetailView.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import SwiftUI

struct InspectionDetailView: View {
    @StateObject private var viewModel: InspectionDetailViewModel
    
    init(viewModel: InspectionDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.inspection.survey.categories.indices, id: \.self) { categoryIndex in
                Section(header: Text(viewModel.inspection.survey.categories[categoryIndex].name)) {
                    ForEach(viewModel.inspection.survey.categories[categoryIndex].questions.indices, id: \.self) { questionIndex in
                        NavigationLink(destination: AnswerChoiceView(viewModel: viewModel, categoryIndex: categoryIndex, questionIndex: questionIndex)) {
                            Text(viewModel.inspection.survey.categories[categoryIndex].questions[questionIndex].name)
                        }
                    }
                }
            }
        }
        .navigationTitle("Inspection Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.submitInspection()
                }) {
                    Text("Submit")
                }
            }
        }
    }
}
