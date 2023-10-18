//
//  ContentView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import SwiftUI
import ARKit

// MARK: Represents the main game view of the application.
struct GameView: View, GameLogicDelegate {
    
    /// The view model responsible for managing game data and logic.
    @EnvironmentObject private var viewModel: GameViewModel
    /// The router manager for handling navigation within the app.
    @EnvironmentObject private var routerManager: NavigationRouter
    
    /// The total score accumulated in the game.
    @State var totalScore: Int = 0
    /// A property indicating whether the game is paused.
    @State var isPaused: Bool = false
    
    /// Method from the `GameLogicDelegate` protocol used to add points to the game.
    mutating func addPoint() {
        self.totalScore += 1
        self.viewModel.points += 1
    }
    
    var body: some View {
        ZStack {
            ARViewContainer(delegate: self)
                .ignoresSafeArea()
            VStack(spacing: 8){
                headerSection
                Spacer()
                dartsLeft
                PrimaryButton(title: "throw") {
                    viewModel.throwDart()
                }
            }
            .padding(40)
            if isPaused {
                PauseView()
            }
        }
        .onAppear{
            /// Set the start time when the view appears.
            viewModel.startTime = Date()
        }
        .onChange(of: totalScore, perform: { newValue in
            /// Update the dart results in the view model when the total score changes.
            viewModel.updateDartResult(at: viewModel.throwNumber - 1)
            print(viewModel.dartResults)
        })
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isGameOver, destination: {
            /// Navigate to the EndMatchView when the game is over.
            EndMatchView(match: viewModel.match)
        })
    }
}

// MARK: Components

extension GameView {
    
    /// The header section displaying the score and pause button.
    var headerSection: some View{
        HStack{
            Spacer()
            Text("Score: \(totalScore)")
                .font(.custom("Futura-Bold", size: 22))
                .foregroundColor(.white)
            Spacer()
            Button {
                ARManager.shared.actionsStream.send(.pause)
                routerManager.push(to: .pause)
            } label: {
                Image(systemName: "pause.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        }
    }
    
    /// The label displaying the current dart throw number.
    var dartsLeft: some View{
        Text("Dart \(viewModel.throwNumber) of 5")
            .font(.custom("Futura-Bold", size: 18))
            .foregroundColor(.white)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(NavigationRouter())
    }
}
