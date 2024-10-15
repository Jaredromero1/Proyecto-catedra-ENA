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
    @State private var isCorrect: Bool = false  // Estado para saber si la respuesta es correcta o incorrecta
    @State private var showPopup: Bool = false  // Cambiado para manejar el popup en lugar del alert
    @State private var currentQuestionIndex = 0
    @State private var timeRemaining = 10  // Tiempo inicial (10 segundos por pregunta)
    @State private var timerActive = true  // Controla si el temporizador está activo
    @State private var timer: Timer? = nil  // Propiedad de estado para el temporizador
    @Environment(\.dismiss) var dismiss // Controla el regreso a la pantalla anterior
    
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
                    // Barra de progreso que muestra el tiempo restante
                    ProgressView(value: Double(timeRemaining) / totalTime)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("sky-blue")))
                        .scaleEffect(x: 1, y: 2, anchor: .center)  // Para hacer más gruesa la barra
                        .padding(.bottom, 35)
                    
                    VStack {
                        Text("What animal is it?")
                            .font(.title3)
                            .bold()
                            .padding(.bottom, 50)
                            .foregroundStyle(.white)
                        
                        if let image = question.image {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 225)
                        }
                    }
                    .padding(.vertical, 50)
                    .background(Color("button-color"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    LazyVGrid(columns: formaGrid, spacing: 10) {
                        ForEach(question.options ?? [], id: \.self) { option in
                            Button(action: {
                                selectedAnswer = option
                                isCorrect = option == question.correctAnswer  // Evaluar si es correcta o incorrecta
                                showPopup = true  // Mostrar el popup en lugar del alert
                                timerActive = false  // Detener el temporizador si el jugador responde
                            }) {
                                Text(option)
                                    .padding()
                                    .bold()
                                    .frame(width: 180, alignment: .center)
                                    .background(selectedAnswer == nil ? Color.white : option == selectedAnswer ? (isCorrect ? Color("greenAnswer") : Color("redAnswer")) : Color.white)
                                    .foregroundStyle(.black)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top, 60)
                }
                .padding()
                .onAppear {
                    startGameTimer()  // Iniciar el temporizador cuando aparezca la vista
                }
                .onDisappear {
                    stopGameTimer()  // Detener el temporizador cuando se salga de la vista
                }
            } else {
                Text("You completed the game!")
                    .font(.largeTitle)
                    .padding()
                
                Button("Back to Levels") {
                    dismiss() // Para regresar manualmente si el juego termina
                }
            }
            
            // Mostrar popup personalizado si showPopup está activo
            if showPopup {
                popupView(question: game.questions[currentQuestionIndex])
                    .transition(.scale)
            }
        }
        .toolbar(.hidden)
    }
    
    // Función que muestra el popup personalizado
    func popupView(question: Question) -> some View {
        ZStack {
            Color.black.opacity(0.4)  // Fondo oscuro semitransparente
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(isCorrect ? "Correct!" : "Incorrect")
                    .font(.title)
                    .bold()
                    .foregroundStyle(isCorrect ? Color.green : Color.red)
                
                Text("The correct answer was:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                // Mostrar la respuesta correcta si está disponible
                Text(question.correctAnswer ?? "Unknown")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.indigo)
                    .padding()
                
                Button(action: {
                    if currentQuestionIndex + 1 < game.questions.count {
                        currentQuestionIndex += 1
                        selectedAnswer = nil
                        showPopup = false  // Ocultar el popup
                        resetTimer()
                    } else {
                        dismiss()  // Finalizar el juego
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
    
    // Método para iniciar el temporizador del juego
    func startGameTimer() {
        stopGameTimer()  // Detener cualquier temporizador anterior si hay uno en ejecución
        timerActive = true
        timeRemaining = Int(totalTime)  // Establece el tiempo inicial

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerActive {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timerActive = false
                    showPopup = true  // Muestra el popup cuando se acaba el tiempo
                    selectedAnswer = nil  // Ninguna respuesta seleccionada (se acaba el tiempo)
                    stopGameTimer()  // Detener el temporizador
                }
            }
        }
    }
    
    // Método para detener el temporizador del juego
    func stopGameTimer() {
        timer?.invalidate()  // Invalidar el temporizador existente
        timer = nil  // Liberar el temporizador
    }

    // Función para reiniciar el temporizador para la siguiente pregunta
    func resetTimer() {
        timeRemaining = Int(totalTime)
        startGameTimer()
    }
}

#Preview {
    let mockGame = Game(
            type: "",
            description: "Choose the correct answer for the image shown.",
            questions: [
                Question(
                    image: "dog",
                    options: ["dog", "cat", "bird", "cow"],
                    correctAnswer: "dog",
                    word: nil,
                    images: nil
                )
            ]
        )
    
    MultipleChoiceGameView(game: mockGame)
}
