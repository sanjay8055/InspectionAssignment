//
//  StartInspectionView.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 20/07/24.
//

import SwiftUI

struct StartInspectionView: View {
    @State private var inspectionType: String = ""
    @StateObject private var inspectionViewModel: InspectionViewModel = InspectionViewModel()
    var body: some View {
        NavigationView {
            List(inspectionViewModel.surveyCategories, id: \.id) { category in
                NavigationLink(destination:InspectionView(category: category).environmentObject(inspectionViewModel)) {
                    HStack {
                        Text(category.name ?? "")
                    }
                }
            }
            .task {
                await inspectionViewModel.startInspection()
            }
            .padding()
            .alert(inspectionViewModel.error, isPresented: isShowingError) {
            }
          
        }
        .navigationTitle("Inspection Category")
    }
    
    var isShowingError: Binding<Bool> {
        Binding {
            !inspectionViewModel.error.isEmpty
        } set: { _ in
            inspectionViewModel.error = ""
        }
    }
}
