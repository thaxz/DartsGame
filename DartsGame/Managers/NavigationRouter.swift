//
//  NavigationRouter.swift
//  DartChallenge
//
//  Created by thaxz on 13/10/23.
//

import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    
    @Published var routes: [Route] = []
    
    // Pushing to any view that is inside of our enum
    func push(to screen: Route){
        routes.append(screen)
    }
    
    // Back to root
    func popToRoot(){
        routes = []
    }
    
    // Back one view
    func popToLast(){
        _ = routes.popLast()
    }
    
}
