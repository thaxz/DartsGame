//
//  MenuView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject private var routeManager = NavigationRouter()
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
                        routeManager.push(to: .game)
                    }
                    SecondaryButton(title: "previous macthes") {
                        // needs to push matches from core data
                        routeManager.push(to: .previousMatches)
                    }
                    SecondaryButton(title: "help") {
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
