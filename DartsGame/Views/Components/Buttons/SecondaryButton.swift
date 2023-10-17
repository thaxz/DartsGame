//
//  SecondaryButton.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primary, lineWidth: 3)
                    .background(
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.theme.secondary)
                    )
                Text(title.uppercased())
                    .font(.custom("Futura-Medium", size: 22))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "previous matches", action: {})
    }
}
