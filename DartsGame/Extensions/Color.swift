//
//  Color.swift
//  DartChallenge
//
//  Created by thaxz on 08/10/23.
//

import Foundation
import SwiftUI

// MARK: Color extension to define the app's color theme.
extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let primary = Color("primaryColor")
    let secondary = Color("secondaryColor")
    let terciary = Color("terciaryColor")
    let background = Color("backgroundColor")
    let rowBg = Color("rowBackgroundColor")
}
