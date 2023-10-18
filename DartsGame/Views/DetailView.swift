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
            VStack(alignment: .center, spacing: 30){
                Text("match nº \(match.id)".uppercased())
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
                Text("\(match.points) points".uppercased())
                    .font(.custom("Futura-Bold", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 160, height: 160)
    }
    
    var timeSection: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.theme.rowBg)
            VStack{
                Image("clockImage")
                Text("\(match.timePassed)".uppercased())
                    .font(.custom("Futura-Bold", size: 20))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 160, height: 160)
    }
    
    var dartsSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.theme.rowBg)
            VStack(spacing: 20){

                ForEach(0..<5){ aux in
                    DartRow(status: stringToBoolArray(match.dartStatus)[aux].description, number: aux + 1)
                }
            }
            .padding()
        }
        .frame(height: 180)
        
    }
    
}

// MARK: Functions

extension DetailView {
    
    func stringToBoolArray(_ inputString: String) -> [Bool] {
        var cleanedString = inputString.replacingOccurrences(of: "[", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "]", with: "")
        let stringArray = cleanedString.components(separatedBy: ", ")
        let boolArray = stringArray.compactMap { Bool($0) }
        return boolArray
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(match: mockMatches[0])
            .environmentObject(NavigationRouter())
    }
}
