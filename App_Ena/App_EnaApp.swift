//
//  App_EnaApp.swift
//  App_Ena
//
//  Created by Jared Romero on 7/10/24.
//

import SwiftUI

@main
struct App_EnaApp: App {
    @State private var showSplashScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showSplashScreen = false
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
