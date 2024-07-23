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
            Text("Question \(currentQuestionIndex + 1) of \(category?.questionsArray.count ?? 0)")
                .font(.headline)
                .padding(.bottom, 10)
            
            Text(category?.questionsArray[currentQuestionIndex].name ?? "")
                .font(.title2)
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
        ForEach(0..<(category?.questionsArray[currentQuestionIndex].answerchoicesArray.count ?? 0), id: \.self) { index in
            Button(action: {
                selectedOptionIndex = index
            }) {
                HStack {
                    Image(systemName: selectedChoice(index: index) ? "largecircle.fill.circle" : "circle")
                        .onAppear {
                            if selectedChoice(index: index) {
                                selectedOptionIndex = index
                            }
                        }
                    Text(category?.questionsArray[currentQuestionIndex].answerchoicesArray[index].name ?? "")
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
            Text(currentQuestionIndex == (category?.questionsArray.count ?? 0) - 1 ? "Submit" : "Next")
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
            category?.questionsArray[currentQuestionIndex].selectedAnswerChoiceId = Int16(selectedOptionIndex)
            inspectionViwModel.saveData()
            totalScore += getScore()
            nextQuestion()
        }
    }
    
    func checkifselectedValueExist(question: Questions?) {
        if let question, question.selectedAnswerChoiceId >= 0 {
            selectedOptionIndex = Int(question.selectedAnswerChoiceId)
        }
    }
    
    func getScore() -> Double {
        if let question = category?.questionsArray[currentQuestionIndex] {
            return Double(question.answerchoicesArray[selectedOptionIndex ?? 0].score)
        }
        return 0.0
    }
    
    func selectedChoice(index: Int) -> Bool {
        if let selectedOptionIndex {
            return selectedOptionIndex == index
        }
        guard let cId = (category?.questionsArray[currentQuestionIndex].selectedAnswerChoiceId), cId >= 0 else {
            return false
        }
        return index == cId
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        selectedOptionIndex = nil
        if currentQuestionIndex >= category?.questionsArray.count ?? 0 {
            currentQuestionIndex = 0
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
