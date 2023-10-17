//
//  PauseView.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct PauseView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.thinMaterial)
                .ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.theme.primary, lineWidth: 5)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(.theme.secondary)
                    )
                VStack(spacing: 40){
                    Text("PAUSED")
                        .font(.custom("Futura-Bold", size: 48))
                        .foregroundColor(.white)
                    HStack{
                        Button {
                            ARManager.shared.actionsStream.send(.play)
                            routerManager.popToLast()
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.theme.primary)
                                .frame(width: 80, height: 80)
                                .overlay(
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 33)
                                )
                        }
                        Spacer()
                        Button {
                            routerManager.popToRoot()
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.theme.primary)
                                .frame(width: 80, height: 80)
                                .overlay(
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 47, height: 44)
                                )
                        }
                    }
                }
                .padding(.horizontal, 55)
            }
            .frame(width: 320, height: 340)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView()
            .environmentObject(NavigationRouter())
    }
}
