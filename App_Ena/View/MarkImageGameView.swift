//
//  MarkImageGameView.swift
//  App_Ena
//
//  Created by Jared Romero on 10/10/24.
//

import SwiftUI

struct MarkImageGameView: View {
    var game: Game
    @State private var selectedImage: String? = nil
    @State private var showResult: Bool = false
    @State private var currentQuestionIndex = 0
    
    var body: some View {
        VStack {
            if currentQuestionIndex < game.questions.count {
                let question = game.questions[currentQuestionIndex]
                
                VStack {
                    if let word = question.word {
                        Text("Select the image for: \(word)")
                            .font(.headline)
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(question.images ?? [], id: \.self) { image in
                            Button(action: {
                                selectedImage = image
                                showResult = true
                            }) {
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .border(selectedImage == image ? Color.blue : Color.clear, width: 4)
                            }
                        }
                    }
                }
                .alert(isPresented: $showResult) {
                    Alert(
                        title: Text(selectedImage == question.correctAnswer ? "Correct!" : "Incorrect"),
                        message: Text("The correct image was \(question.correctAnswer)"),
                        dismissButton: .default(Text("Next")) {
                            currentQuestionIndex += 1
                            selectedImage = nil
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
//    MarkImageGameView()
//}
