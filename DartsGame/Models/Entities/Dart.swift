//
//  MyDart.swift
//  DartChallenge
//
//  Created by thaxz on 17/10/23.
//

import Foundation
import SceneKit

// MARK: Class representing the darts that are thrown at the scene

class Dart: SCNNode {
    override init () {
        super.init()
        /// Creating geometry
        let sphere = SCNSphere(radius: 0.025)
        self.geometry = sphere
        /// Creating physics shape
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        /// Setting collision bitmasks
        self.physicsBody?.categoryBitMask = CollisionCategory.darts.rawValue // Applying Dart BitMask
        self.physicsBody?.contactTestBitMask = CollisionCategory.dartBoard.rawValue // Bitmask of what is going to collide with
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "dart")
        self.geometry?.materials  = [material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
