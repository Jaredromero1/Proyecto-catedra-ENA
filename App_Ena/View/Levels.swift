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
            Color("background-dark")
                .ignoresSafeArea()
            
            VStack {
                Text("Select a Level")
                    .font(.title2)
                    .padding()
                    .bold()
                    .foregroundStyle(.white)
                
                ScrollView {
                    LazyVGrid(columns: formaGrid, spacing: 8) {
                        ForEach(lesson.games.indices, id: \.self) { index in
                            NavigationLink(destination: GameDeatilView(game: lesson.games[index])) {
                                VStack {
                                    Text("\(index + 1)")
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(Color("button-color"))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.vertical, 10)
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
            VStack {
                Text("\(game.type)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(game.description)
                    .foregroundStyle(.gray)
                    .font(.title2)
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Botón para empezar juego
            NavigationLink(destination: startGameView(for: game)) {
                Text("Start Game")
                    .font(.title3)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
        }
        .background(Color("background-dark"))
    }
    
    @ViewBuilder
    func startGameView(for game: Game) -> some View {
        if game.type == "Multiple choice" {
            MultipleChoiceGameView(game: game)
        } else if game.type == "Image selection" {
            MarkImageGameView(game: game)
        } else {
            Text("Unknown game type")
        }
    }
}

#Preview {
    EmptyView()
}
