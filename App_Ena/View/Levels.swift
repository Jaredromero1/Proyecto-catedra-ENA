//
//  Levels.swift
//  App_Ena
//
//  Created by Jared Romero on 10/10/24.
//

import SwiftUI

struct Levels: View {
    var lesson: Lesson
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                Text("Select a Level")
                    .font(.title2)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: formaGrid, spacing: 8) {
                        ForEach(lesson.games.indices, id: \.self) { index in
                            NavigationLink(destination: GameDeatilView(game: lesson.games[index])) {
                                VStack {
                                    Text("\(index + 1)")
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(.black)
                                }
                                .padding()
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
            }
        }
    }
}

struct GameDeatilView: View {
    var game: Game
    
    var body: some View {
        VStack {
            Text("Game Mode: \(game.type)")
                .font(.largeTitle)
                .padding()
            
            Text(game.description)
                .font(.title2)
                .padding()
            
            // Botón para empezar juego
            NavigationLink(destination: startGameView(for: game)) {
                Text("Start Game")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func startGameView(for game: Game) -> some View {
        if game.type == "Selección multiple" {
            MultipleChoiceGameView(game: game)
        } else if game.type == "Marcar imagen" {
            MarkImageGameView(game: game)
        } else {
            Text("Unknown game type")
        }
    }
}

#Preview {
    ContentView()
}


//Text("Game type: \(game.type)")
    //.toolbar(.hidden)
