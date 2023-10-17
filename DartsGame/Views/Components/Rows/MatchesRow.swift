//
//  MacthesRow.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct MacthesRow: View {
    let match: Match
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.theme.rowBg)
            VStack(alignment: .leading, spacing: 8){
                Text("Match nº \(match.id)".uppercased())
                    .font(.custom("Futura-Bold", size: 22))
                    .foregroundColor(.white)
                Text("TOTAL TIME: \(match.timePassed) seconds".uppercased())
                    .font(.custom("Futura-Medium", size: 16))
                    .foregroundColor(.white)
                Text("POINTS: \(match.points)".uppercased())
                    .font(.custom("Futura-Medium", size: 16))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}

struct MacthesRow_Previews: PreviewProvider {
    static var previews: some View {
        MacthesRow(match: mockMatches[0])
    }
}
