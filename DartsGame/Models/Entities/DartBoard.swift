//
//  DartBoard.swift
//  DartChallenge
//
//  Created by thaxz on 17/10/23.
//

import UIKit
import SceneKit

// Floating dartboard that randonly appears
class DartBoard: SCNNode {
    override init() {
        super.init()
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.0, chamferRadius: 0)
        self.geometry = box
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        self.physicsBody?.categoryBitMask = CollisionCategory.dartBoard.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.darts.rawValue
        
        // add texture
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "dartboard")
        self.geometry?.materials  = [material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
