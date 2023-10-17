//
//  PrimaryDestination.swift
//  DartChallenge
//
//  Created by thaxz on 09/10/23.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.theme.primary)
                Text(title.uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

struct PrimaryLabel_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "play", action: {})
    }
}
