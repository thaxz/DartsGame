//
//  EndMatchView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

// MARK: Represents the end match view displayed at the conclusion of a match
struct EndMatchView: View {
    
    /// The router manager for handling navigation within the app.
    @EnvironmentObject private var routerManager: NavigationRouter
    /// The match object containing game data.
    let match: Match?
    
    var body: some View {
        ZStack {
            Image("endMatchBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 32){
                Text("END OF THE MATCH")
                    .font(.custom("Futura-Bold", size: 50))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 70)
                Image("board")
                    .resizable()
                    .frame(width: 120, height: 120)
                pointsSection
                timeSection
                Spacer()
                PrimaryButton(title: "see details") {
                    routerManager.push(to: .matchDetails(match: match))
                }
                SecondaryButton(title: "main menu") {
                    routerManager.popToRoot()
                }
                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: Components

extension EndMatchView {
    
    /// Section displaying the achieved points.
    var pointsSection: some View {
        VStack{
            Text("YOU ACHIEVED")
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(.white)
            Text("\(match?.points ?? 0) POINTS")
                .font(.custom("Futura-Medium", size: 22))
                .underline()
                .foregroundColor(.white)
        }
    }
    
    /// Section displaying the time elapsed during the match.
    var timeSection: some View {
        HStack{
            Image(systemName: "clock")
                .resizable()
                .foregroundColor(Color.theme.primary)
                .frame(width: 26, height: 26)
            Text("IN \(match?.timePassed ?? "0 seconds")".uppercased())
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(Color.theme.primary)
        }
    }
    
}
