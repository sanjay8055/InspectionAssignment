//
//  InspectionView.swift
//  InspectionAssignment
//
//  Created by Sanjay Raskar on 21/07/24.
//

import SwiftUI

struct InspectionView: View {
    
    @State private var currentQuestionIndex = 0
    @State private var selectedOptionIndex: Int?
    @State private var showingResult = false
    @State private var totalScore = 0.0

    @EnvironmentObject var inspectionViwModel: InspectionViewModel
    var category: Category?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Question \(currentQuestionIndex + 1) of \(category?.questions.count ?? 0)")
                .font(.headline)
                .padding(.bottom, 10)
            
            Text(category?.questions[currentQuestionIndex].name ?? "")
                .font(.title)
                .padding(.bottom, 20)
            
            QuestionChoiceView
            
            submitButton
        }
        .padding()
        .alert(inspectionViwModel.error, isPresented: isShowingError) {
        }
        .alert("Total score: " + String(format: "%.2f", totalScore), isPresented: $showingResult) {
            Button("Ok") {
                dismiss()
            }
        }
    }
    
    var QuestionChoiceView: some View {
        ForEach(0..<(category?.questions[currentQuestionIndex].answerChoices.count ?? 0), id: \.self) { index in
            Button(action: {
                selectedOptionIndex = index
            }) {
                HStack {
                    Image(systemName: selectedOptionIndex == index ? "largecircle.fill.circle" : "circle")
                    Text(category?.questions[currentQuestionIndex].answerChoices[index].name ?? "")
                        .font(.body)
                        .padding(.leading, 5)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 10)
        }
    }
    
    var submitButton: some View {
        Button(action: {
            checkAnswer()
        }) {
            Text(currentQuestionIndex == (category?.questions.count ?? 0) - 1 ? "Submit" : "Next")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedOptionIndex == nil ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.top, 20)
        .disabled(selectedOptionIndex == nil)
    }
    var isShowingError: Binding<Bool> {
        Binding {
            !inspectionViwModel.error.isEmpty
        } set: { _ in
            inspectionViwModel.error = ""
        }
    }
    
    func checkAnswer() {
        if let selectedOptionIndex = selectedOptionIndex {
            inspectionViwModel.saveDraftInspection(categoryIndex: category?.id ?? 0, questionIndex: currentQuestionIndex, choiceId: selectedOptionIndex)
            totalScore += getScore()
            nextQuestion()
        }
    }
    
    func getScore() -> Double {
        if let question = category?.questions[currentQuestionIndex] {
            return question.answerChoices[selectedOptionIndex ?? 0].score ?? 0.0
        }
        return 0.0
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        selectedOptionIndex = nil
        if currentQuestionIndex >= category?.questions.count ?? 0 {
            currentQuestionIndex = 0 // Restart quiz or navigate to result screen
            showingResult = true
            
            Task {
                await inspectionViwModel.submitInspection()
            }
        }
    }
}

#Preview {
    InspectionView()
}
