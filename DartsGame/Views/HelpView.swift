//
//  HelpView.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import SwiftUI

// MARK: Represents the view providing instructions to the users about how to play the game
struct HelpView: View {
    
    /// The router manager for handling navigation within the app.
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        ZStack {
            Image("helpBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.primary, lineWidth: 3)
                        .background(
                            RoundedRectangle(cornerRadius: 20).foregroundColor(.theme.secondary)
                        )
                    TabView{
                        firstSection
                        secondSection
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
                .padding(.vertical, 100)
                PrimaryButton(title: "main menu") {
                    routerManager.popToLast()
                }
                
                Spacer()
                    .frame(height: 70)
            }
            .padding(.horizontal, 30)
            .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: Components

extension HelpView {
    
    /// The first section of help content explaining how to play the game.
    var firstSection: some View {
        VStack(spacing: 20){
            Text("HOW TO PLAY")
                .font(.custom("Futura-Bold", size: 35))
                .foregroundColor(.white)
            Text("- look for the boards around the scene".uppercased())
                .font(.custom("Futura-Medium", size: 20))
                .foregroundColor(.white)
            Text("- Center the phone with the board".uppercased())
                .font(.custom("Futura-Medium", size: 20))
                .foregroundColor(.white)
            Text("- throw a dart, pressing the button".uppercased())
                .font(.custom("Futura-Medium", size: 20))
                .foregroundColor(.white)
            Text("- you have 5 darts".uppercased())
                .font(.custom("Futura-Medium", size: 20))
                .foregroundColor(.white)
            Text("HAVE FUN!".uppercased())
                .underline()
                .font(.custom("Futura-Bold", size: 20))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(20)
        .multilineTextAlignment(.center)
    }
    
    /// The second section of help content
    var secondSection: some View {
        VStack(spacing: 30){
            Spacer()
            Text("this is an ar DARTS game".uppercased())
                .font(.custom("Futura-Medium", size: 20))
                .foregroundColor(.white)
            Text(" developed by \nthais monteiro".uppercased())
                .font(.custom("Futura-Medium", size: 20))
                .foregroundColor(.white)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .environmentObject(NavigationRouter())
    }
}
