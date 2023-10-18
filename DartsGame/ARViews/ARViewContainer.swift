//
//  ARViewContainer.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI
import ARKit

// MARK: A SwiftUI representation of the ARKit view controller.
struct ARViewContainer: UIViewControllerRepresentable {
    
    /// The delegate responsible for game logic.
    let delegate: GameLogicDelegate
    
    /// Required typealias to conform to UIViewControllerRepresentable protocol.
    typealias UIViewControllerType = GameViewController
    
    /// Creates and configures the ARKit view controller.
    /// - Parameter context: The context in which SwiftUI calls this method.
    /// - Returns: A configured instance of GameViewController.
    func makeUIViewController(context: Context) -> GameViewController {
        let viewController = GameViewController()
        viewController.gameLogicDelegate = delegate
        return viewController
    }
    
    /// Updates the presented view controller.
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // No implementation needed for this method.
    }
}



