//
//  ContentView.swift
//  App_Ena
//
//  Created by Jared Romero on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Home()
            }
        }
    }
}

struct Home: View {
    @StateObject var dataLoader = DataLoader.shared
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                Text("Word Cards")
                    .padding(.vertical, 20)
                    .font(.title2)
                
                ScrollView {
                    LazyVGrid(columns: formaGrid, spacing: 8) {
                        ForEach(dataLoader.lessons, id: \.topic) { lesson in
                            NavigationLink(destination: Levels(lesson: lesson)) {
                                VStack(alignment: .leading) {
                                    Text(lesson.topic)
                                        .font(.callout)
                                        .foregroundStyle(.black)
                                
                                    Image(lesson.topic)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120)
                                }
                                .padding()
                                .frame(width: 180, alignment: .center)
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

#Preview {
    ContentView()
}

//NavigationLink(destination: Levels()) {
//    VStack(alignment: .leading) {
//        Text(type)
//    
//        Image(type)
//            .resizable()
//            .scaledToFit()
//            .frame(width: 120, height: 120)
//    }
//    .padding()
//    .frame(width: 180, alignment: .center)
//    .background(Color.white)
//    .clipShape(RoundedRectangle(cornerRadius: 15))
//}


//ScrollView {
//    LazyVGrid(columns: formaGrid, spacing: 8) {
//        ForEach(types, id: \.self) { type in
//            NavigationLink(destination: Levels()) {
//                VStack(alignment: .leading) {
//                    Text(type)
//                        .font(.callout)
//                        .foregroundStyle(.black)
//                
//                    Image(type)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 120, height: 120)
//                }
//                .padding()
//                .frame(width: 180, alignment: .center)
//                .background(Color.white)
//                .clipShape(RoundedRectangle(cornerRadius: 15))
//            }
//        }
//    }
//}
//.scrollIndicators(.hidden)
//.padding(.horizontal)
