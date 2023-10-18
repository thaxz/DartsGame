//
//  EndMatchView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct EndMatchView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    let match: Match
    
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
    
    var pointsSection: some View {
        VStack{
            Text("YOU ACHIEVED")
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(.white)
            Text("\(match.points) POINTS")
                .font(.custom("Futura-Medium", size: 22))
                .underline()
                .foregroundColor(.white)
        }
    }
    
    var timeSection: some View {
        HStack{
            Image(systemName: "clock")
                .resizable()
                .foregroundColor(Color.theme.primary)
                .frame(width: 26, height: 26)
            Text("IN \(match.timePassed) SECONDS".uppercased())
                .font(.custom("Futura-Medium", size: 22))
                .foregroundColor(Color.theme.primary)
        }
    }
    
}

struct EndMatchView_Previews: PreviewProvider {
    static var previews: some View {
        EndMatchView(match: mockMatches[0])
            .environmentObject(NavigationRouter())
    }
}
