//
//  InspectionListView.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import SwiftUI

struct InspectionListView: View {
    var body: some View {
        NavigationView {
            TabView {
                OngoingInspectionsView()
                    .tabItem {
                        Label("Inspections", systemImage: "list.dash")
                    }
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }
            }
            .navigationTitle("Inspections")
        }
    }
}

struct OngoingInspectionsView: View {
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
                            VStack(alignment: .leading) {
                                Text("Inspection \(inspection.id)")
                                Text("Final Score: \(InspectionDetailViewModel(inspection: inspection).finalScore, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                viewModel.fetchInspections()
            }
        }
    }
}
