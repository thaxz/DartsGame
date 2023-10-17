//
//  DetailView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    let match: Match
    
    var body: some View {
        ZStack(alignment: .leading){
            Color.theme.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 30){
                Text("match nº \(match.id)".uppercased())
                    .font(.custom("Futura-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                HStack {
                    pointsSection
                    Spacer()
                    timeSection
                }
                dartsSection
                Spacer()
                VStack(spacing: 24){
                    PrimaryButton(title: "previous macthes") {
                        routerManager.popToLast()
                    }
                    SecondaryButton(title: "main menu") {
                        routerManager.popToRoot()
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: Components

extension DetailView {
    
    var pointsSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("medalImage")
                Text("\(match.points)".uppercased())
                    .font(.custom("Futura-Bold", size: 16))
                    .foregroundColor(.white)
                Text("points".uppercased())
                    .font(.custom("Futura-Medium", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 180, height: 180)
    }
    
    var timeSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("clockImage")
                Text("\(match.timePassed)".uppercased())
                    .font(.custom("Futura-Bold", size: 16))
                    .foregroundColor(.white)
                Text("seconds".uppercased())
                    .font(.custom("Futura-Medium", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 180, height: 180)
    }
    
    var dartsSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.theme.rowBg)
            VStack(spacing: 20){
                ForEach(0..<5){ aux in
                    DartRow(status: match.dartStatus[aux].description, number: aux + 1)
                }
            }
            .padding()
        }
        .frame(height: 180)
        
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(match: mockMatches[0])
            .environmentObject(NavigationRouter())
    }
}
