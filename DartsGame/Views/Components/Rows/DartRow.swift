//
//  DartRow.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import SwiftUI

struct DartRow: View {
    let status: String
    let number: Int
    var body: some View {
        HStack {
            Text("Dart \(number)")
                .font(.custom("Futura-Medium", size: 18))
                .foregroundColor(.white)
            Spacer()
            Text(status == "true" ? "HIT" : "MISS")
                .font(.custom("Futura-Bold", size: 18))
                .foregroundColor(status == "true" ? Color.theme.terciary : Color.theme.primary)
        }
    }
}

struct DartRow_Previews: PreviewProvider {
    static var previews: some View {
        DartRow(status: "HIT", number: 2)
    }
}
