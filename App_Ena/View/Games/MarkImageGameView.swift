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
    @State private var showPopup: Bool = false
    @State private var currentQuestionIndex = 0
    @State private var timeRemaining = 10  // Tiempo inicial (10 segundos por pregunta)
    @State private var timerActive = true  // Controla si el temporizador está activo
    @State private var timer: Timer? = nil  // Propiedad de estado para el temporizador
    @Environment(\.dismiss) var dismiss
    
    let totalTime: Double = 10  // Tiempo total para cada pregunta
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color("background-dark")
                .ignoresSafeArea()
            
            if currentQuestionIndex < game.questions.count {
                let question = game.questions[currentQuestionIndex]
                
                VStack {
                    ProgressView(value: Double(timeRemaining) / totalTime)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("sky-blue")))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding(.bottom, 35)
                    
                    
                    if let word = question.word {
                        VStack {
                            Text("Select the image for:")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(word)
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color("sky-blue"))
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 35)
                        .background(Color("button-color"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 50)
                    }
                    
                    LazyVGrid(columns: formaGrid, spacing: 8) {
                        ForEach(question.images ?? [], id: \.self) { image in
                            Button(action: {
                                selectedImage = image
                                showPopup = true
                                timerActive = false
                            }) {
                                VStack {
                                    Image(image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                }
                                .frame(width: 180, height: 150, alignment: .center)
                                .background(
                                    // Cambiar el color de fondo según la respuesta seleccionada
                                    selectedImage == nil ? Color.white :
                                    selectedImage == image ? (selectedImage == question.correctAnswer ? Color("greenAnswer") : Color("redAnswer")) : Color.white
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                .onAppear {
                    startGameTimer()
                }
                .onDisappear {
                    stopGameTimer()
                }
            } else {
                Text("You've completed the game!")
                    .font(.largeTitle)
                    .padding()
                
                Button("Back to Levels") {
                    dismiss()
                }
            }
            
            if showPopup {
                popupView(question: game.questions[currentQuestionIndex])
                    .transition(.scale)
            }
        }
        .toolbar(.hidden)
    }
    
    func popupView(question: Question) -> some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(selectedImage == question.correctAnswer ? "Correct!" : "Incorrect")
                    .font(.title)
                    .bold()
                    .foregroundStyle(selectedImage == question.correctAnswer ? Color.green : Color.red)
                
                Text("The correct image was:")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                if let correctImage = question.correctAnswer {
                    Image(correctImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                }
                
                Button(action: {
                    if currentQuestionIndex + 1 < game.questions.count {
                        currentQuestionIndex += 1
                        selectedImage = nil
                        showPopup = false
                        resetTimer()
                    } else {
                        dismiss()
                    }
                }) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("sky-blue"))
                        .foregroundStyle(Color("button-color"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .frame(width: 300)
            .padding()
            .background(Color("button-color"))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
    
    func startGameTimer() {
        stopGameTimer()
        timerActive = true
        timeRemaining = Int(totalTime)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerActive {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timerActive = false
                    showPopup = true
                    selectedImage = nil
                    stopGameTimer()
                }
            }
        }
    }
    
    func stopGameTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        timeRemaining = Int(totalTime)
        startGameTimer()
    }
    
}


#Preview {
    let mockGame = Game(
        type: "Marcar imagen",
        description: "Mark the correct image for the word shown.",
        questions: [
            Question(
                image: nil,
                options: nil,
                correctAnswer: nil,
                word: "Dog",
                images: ["dog", "cat", "elephant", "cow"]
            )
        ]
    )
    
    MarkImageGameView(game: mockGame)
}
