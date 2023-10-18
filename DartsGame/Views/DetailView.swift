//
//  DetailView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

// MARK: Represents the detailed view displaying match information.
struct DetailView: View {
    
    /// The router manager for handling navigation within the app.
    @EnvironmentObject private var routerManager: NavigationRouter
    /// The match object containing game data.
    let match: Match?
    
    var body: some View {
        ZStack(alignment: .leading){
            Color.theme.background.ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                Text("match nº \(match?.id ?? 0)".uppercased())
                    .font(.custom("Futura-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                HStack(alignment: .center, spacing: 30){
                    pointsSection
                    timeSection
                }
                Spacer()
                dartsSection
                Spacer()
                PrimaryButton(title: "previous macthes") {
                    routerManager.push(to: .previousMatches)
                }
                SecondaryButton(title: "main menu") {
                    routerManager.popToRoot()
                }
                
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: Components

extension DetailView {
    
    /// Section displaying the achieved points.
    var pointsSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("medalImage")
                Text("\(match?.points ?? 0) points".uppercased())
                    .font(.custom("Futura-Bold", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 160, height: 160)
    }
    
    /// Section displaying the time elapsed during the match.
    var timeSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("clockImage")
                Text("\(match?.timePassed ?? "0 seconds")".uppercased())
                    .font(.custom("Futura-Bold", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 160, height: 160)
    }
    
    /// Section displaying the individual darts' results.
    var dartsSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.theme.rowBg)
            VStack(spacing: 10){
                ForEach(0..<5){ aux in
                    DartRow(status: stringToBoolArray((match?.dartStatus)!)[aux].description, number: aux + 1)
                    Divider()
                }
            }
            .padding()
        }
        .frame(height: 180)
        
    }
    
}

// MARK: Functions

extension DetailView {
    
    /// Converts a string representing dart statuses to an array of Booleans.
    /// - Parameter inputString: The input string containing dart status.
    /// - Returns: An array of Booleans representing dart status.
    func stringToBoolArray(_ inputString: String) -> [Bool] {
        var cleanedString = inputString.replacingOccurrences(of: "[", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "]", with: "")
        let stringArray = cleanedString.components(separatedBy: ", ")
        let boolArray = stringArray.compactMap { Bool($0) }
        return boolArray
    }
}

