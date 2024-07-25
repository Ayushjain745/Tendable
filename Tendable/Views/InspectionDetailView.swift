//
//  InspectionDetailView.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import SwiftUI

struct InspectionDetailView: View {
    @StateObject private var viewModel: InspectionDetailViewModel
    @State private var showAlert = false
    @State private var alert: Alert?
    let isReadOnly: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: InspectionDetailViewModel, isReadOnly: Bool = false) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.isReadOnly = isReadOnly
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.inspection.survey.categories.indices, id: \.self) { categoryIndex in
                    Section(header: Text(viewModel.inspection.survey.categories[categoryIndex].name)) {
                        ForEach(viewModel.inspection.survey.categories[categoryIndex].questions.indices, id: \.self) { questionIndex in
                            NavigationLink(destination: AnswerChoiceView(viewModel: viewModel, categoryIndex: categoryIndex, questionIndex: questionIndex, isReadOnly: self.isReadOnly)) {
                                Text(viewModel.inspection.survey.categories[categoryIndex].questions[questionIndex].name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Inspection Details")
            
            Text("Final Score: \(viewModel.finalScore, specifier: "%.2f")")
                .padding()
            
            if !isReadOnly {
                Button(action: {
                    viewModel.submitInspection { success in
                        if success {
                            alert = Alert(title: Text("Success"), message: Text("Inspection submitted successfully!"), dismissButton: .default(Text("OK"), action: {
                                // Dismiss the view when the alert is dismissed
                                presentationMode.wrappedValue.dismiss()
                            }))
                            
                        } else {
                            alert = Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "An error occurred"), dismissButton: .default(Text("OK")))
                        }
                        showAlert = true
                    }
                })
                {
                    Text("Submit")
                }
                .alert(isPresented: $showAlert) {
                    alert ?? Alert(title: Text("Success"))
                }
            }
        }
    }
}

