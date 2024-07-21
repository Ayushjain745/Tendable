//
//  InspectionListView.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import SwiftUI

struct InspectionListView: View {
    @StateObject private var viewModel = InspectionListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(viewModel.inspections) { inspection in
                        NavigationLink(destination: InspectionDetailView(viewModel: InspectionDetailViewModel(inspection: inspection))) {
                            Text("Inspection \(inspection.id)")
                        }
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Inspections")
            .onAppear {
                viewModel.fetchInspections()
            }
        }
    }
}
