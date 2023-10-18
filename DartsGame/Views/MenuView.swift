//
//  MenuView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

// MARK: Represents the main menu view of the application.
struct MenuView: View {
    
    /// The router manager for handling navigation within the app.
    @StateObject private var routeManager = NavigationRouter()
    /// The view model for managing game logic and data.
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        NavigationStack(path: $routeManager.routes){
            ZStack {
                Image("menuBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 20){
                    Image("logo")
                        .padding(.top, 70)
                    Spacer()
                    PrimaryButton(title: "play") {
                        /// Navigating to the game view.
                        routeManager.push(to: .game)
                    }
                    SecondaryButton(title: "previous macthes") {
                        /// Navigating to the previous maches view.
                        routeManager.push(to: .previousMatches)
                    }
                    SecondaryButton(title: "help") {
                        /// Navigating to the help view.
                        routeManager.push(to: .help)
                    }
                    Spacer()
                        .frame(height: 70)
                }
                .padding(.horizontal, 20)
            }
            .navigationDestination(for: Route.self) { route in
                route
            }
        }
        .environmentObject(routeManager)
        .environmentObject(viewModel)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
