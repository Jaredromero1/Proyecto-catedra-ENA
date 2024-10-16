//
//  SplashScreenView.swift
//  App_Ena
//
//  Created by Jared Romero on 16/10/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.6
    @State private var blurAmount: CGFloat = 8.0

    var body: some View {
        ZStack {
            if isActive {
                ContentView()
            } else {
                ZStack {
                    Color("background-dark")
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("Bilingo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color("sky-blue"))
                    }
                    .scaleEffect(size)
                    .blur(radius: blurAmount)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 2.0
                            blurAmount = 0
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
