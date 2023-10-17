//
//  ARViewContainer.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import SwiftUI
import ARKit

struct ARViewContainer: UIViewControllerRepresentable {
    
    let delegate: GameLogicDelegate
    
    typealias UIViewControllerType = GameViewController

    func makeUIViewController(context: Context) -> GameViewController {
        let viewController = GameViewController()
        viewController.gameLogicDelegate = delegate
        return viewController
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
    }
}



