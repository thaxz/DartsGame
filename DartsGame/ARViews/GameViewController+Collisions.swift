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
    
    /// Called when a physics contact occurs in the scene.
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.dartBoard.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.dartBoard.rawValue {
            print("Hit board!")
            self.removeNodeWithAnimation(contact.nodeB, isCollision: false)
            self.addPoint()
            // Delay and then remove and replace the dartboard
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.removeNodeWithAnimation(contact.nodeA, isCollision: true)
                self.addNewBoard()
            })
            
        }
    }
    
}
