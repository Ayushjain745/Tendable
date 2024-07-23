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
                NavigationLink(destination: InspectionDetailView(viewModel: InspectionDetailViewModel(inspection: inspection))) {
                    Text("Inspection #\(inspection.id)")
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
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
