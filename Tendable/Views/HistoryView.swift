//
//  HistoryView.swift
//  Tendable
//
//  Created by Ayush Jain on 23/07/24.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.inspections) { inspection in
                NavigationLink(destination: InspectionDetailView(viewModel: InspectionDetailViewModel(inspection: inspection), isReadOnly: true)) {
                    VStack(alignment: .leading) {
                        Text("Inspection #\(inspection.id)")
                            .font(.headline)
                        Text("Area: \(inspection.area.name)")
                            .font(.subheadline)
                        Text("Score: \(calculateScore(for: inspection), specifier: "%.2f")")
                            .font(.subheadline)
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.fetchHistory()
            }
            .navigationBarTitle("Inspection History")
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateScore(for inspection: Inspection) -> Double {
        let answeredQuestions = inspection.survey.categories.flatMap { $0.questions }.filter { $0.selectedAnswerChoiceId != nil }
        return answeredQuestions.reduce(0) { total, question in
            let score = question.answerChoices.first { $0.id == question.selectedAnswerChoiceId }?.score ?? 0
            return total + score
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
