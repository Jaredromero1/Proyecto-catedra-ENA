//
//  MultipleChoiceGameViwe.swift
//  App_Ena
//
//  Created by Jared Romero on 10/10/24.
//

import SwiftUI

struct MultipleChoiceGameView: View {
    var game: Game
    @State private var selectedAnswer: String? = nil
    @State private var showResult: Bool = false
    @State private var currentQuestionIndex = 0
    
    var body: some View {
        VStack {
            if currentQuestionIndex < game.questions.count {
                let question = game.questions[currentQuestionIndex]
                
                VStack {
                    if let image = question.image {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    Text("Choose the correct answer:")
                        .font(.headline)
                    
                    ForEach(question.options ?? [], id: \.self) { option in
                        Button(action: {
                            selectedAnswer = option
                            showResult = true
                        }) {
                            Text(option)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                }
                .alert(isPresented: $showResult) {
                    Alert(
                        title: Text(selectedAnswer == question.correctAnswer ? "Correct!" : "Incorrect"),
                        message: Text("The correct answer was \(question.correctAnswer)"),
                        dismissButton: .default(Text("Next")) {
                            currentQuestionIndex += 1
                            selectedAnswer = nil
                        }
                    )
                }
            } else {
                Text("You've completed the game!")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .padding()
    }
}


//#Preview {
//    MultipleChoiceGameViwe()
//}
