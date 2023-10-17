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
                trowButton
            }
            .padding(40)
            if isPaused {
                PauseView()
            }
        }
        .onAppear{
            viewModel.startTime = Date()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isGameOver, destination: {
            EndMatchView(match: viewModel.match ?? mockMatches[0])
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
    
    var trowButton: some View {
        Button {
            ARManager.shared.actionsStream.send(.placeDart)
            viewModel.throwNumber += 1
            if viewModel.throwNumber >= 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    viewModel.gameOver()
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.theme.primary)
                Text("trow".uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(NavigationRouter())
    }
}
