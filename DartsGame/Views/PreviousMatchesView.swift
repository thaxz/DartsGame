//
//  PreviousMatchesView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

// MARK: Represents the view displaying previous match records.
struct PreviousMatchesView: View {
    
    /// The router manager for handling navigation within the app.
    @EnvironmentObject private var routerManager: NavigationRouter
    /// The view model for managing game logic and data.
    @EnvironmentObject private var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                HStack(spacing: 20){
                    Image("board")
                        .resizable()
                        .frame(width: 120, height: 120)
                    Text("PREVIOUS MATCHES")
                        .font(.custom("Futura-Bold", size: 32))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                if viewModel.matches.isEmpty {
                    noMatchesView
                } else {
                    ScrollView{
                        ForEach(viewModel.matches) { match in
                            MacthesRow(match: match)
                            /// When a previous match row is tapped, navigate to the detailed view of that match.
                                .onTapGesture {
                                    routerManager.push(to: .matchDetails(match: match))
                                }
                        }
                    }
                }
                Spacer()
                PrimaryButton(title: "main menu") {
                    routerManager.popToRoot()
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: Components

extension PreviousMatchesView{
    
    var noMatchesView: some View{
        VStack(spacing: 32){
            Image(systemName: "exclamationmark.bubble")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.theme.primary)
            Text("You haven't played any games yet!".uppercased())
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 100)
    }
    
}

struct PreviousMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousMatchesView()
            .environmentObject(NavigationRouter())
    }
}
