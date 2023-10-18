//
//  ContentView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import SwiftUI
import ARKit

struct GameView: View, GameLogicDelegate {
    
    @StateObject private var viewModel = GameViewModel()
    @EnvironmentObject private var routerManager: NavigationRouter
    
    @State var totalScore: Int = 0
    @State var isPaused: Bool = false
    
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
                    if viewModel.throwNumber < 5 {
                        ARManager.shared.actionsStream.send(.placeDart)
                        viewModel.throwNumber += 1
                        if viewModel.throwNumber >= 5 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                viewModel.gameOver()
                            }
                        }
                    }
                }
            }
            .padding(40)
            if isPaused {
                PauseView()
            }
        }
        .onAppear{
            viewModel.startTime = Date()
        }
        .onChange(of: totalScore, perform: { newValue in
            viewModel.updateDartResult(at: viewModel.throwNumber - 1)
            print(viewModel.dartResults)
        })
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isGameOver, destination: {
            EndMatchView(match: viewModel.match)
        })
    }
}

// MARK: Components

extension GameView {
    
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
