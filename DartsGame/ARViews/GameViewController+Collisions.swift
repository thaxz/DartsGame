//
//  GameViewController+Collisions.swift
//  DartsGame
//
//  Created by thaxz on 17/10/23.
//

import Foundation
import ARKit

// MARK: Collisions

extension GameViewController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.dartBoard.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.dartBoard.rawValue {
            print("Hit board!")
            self.removeNodeWithAnimation(contact.nodeB, explosion: false) // remove dart
            self.userScore += 1
            self.addPoint()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { // remove&replace board
                self.removeNodeWithAnimation(contact.nodeA, explosion: true)
                self.addNewBoard()
            })
            
        }
    }
    
}
