//
//  DartBoard.swift
//  DartChallenge
//
//  Created by thaxz on 17/10/23.
//

import UIKit
import SceneKit

// MARK: Class representing a floating dartboard that randomly appears in the scene

class DartBoard: SCNNode {
    override init() {
        super.init()
        /// Creating geometry
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.0, chamferRadius: 0)
        self.geometry = box
        /// Creating physics shape
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        /// Setting collision bitmasks
        self.physicsBody?.categoryBitMask = CollisionCategory.dartBoard.rawValue // Applying Board BitMask
        self.physicsBody?.contactTestBitMask = CollisionCategory.darts.rawValue // Bitmask of what is going to collide with
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "dartboard")
        self.geometry?.materials  = [material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
