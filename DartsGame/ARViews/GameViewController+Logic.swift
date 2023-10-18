//
//  GameViewController+Logic.swift
//  DartsGame
//
//  Created by thaxz on 17/10/23.
//

import ARKit
import RealityKit
import Combine

// MARK: Game Functionality

extension GameViewController {
    
    /// Configures the AR session based on device capabilities.
    func configureSession() {
        if ARWorldTrackingConfiguration.isSupported {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        sceneView.session.run(configuration)
        } else {
            // less immersive AR experience due to lower end processor
            let configuration = AROrientationTrackingConfiguration()
            sceneView.session.run(configuration)
        }
    }
    
    /// Retrieves the user's direction and position in the AR world.
    func getUserVector() -> (SCNVector3, SCNVector3) {
        if let frame = self.sceneView.session.currentFrame {
            // 4x4 transform matrix describing camera in world space
            let mat = SCNMatrix4(frame.camera.transform)
            // orientation of camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
            // location of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43)
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    /// Throws a dart and plays a sound in the scene.
    func throwDart() {
        SoundManager.shared.playSound(sound: .throwDart)
        let dartsNode = Dart()
        let (direction, position) = self.getUserVector()
        dartsNode.position = position
        let dartsDirection = direction
        dartsNode.physicsBody?.applyForce(dartsDirection, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(dartsNode)
    }
    
    /// Adds a new dartboard to the scene at a random position.
    func addNewBoard() {
        let boardNode = DartBoard()
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5  )
        boardNode.position = SCNVector3(posX, posY, -1)
        sceneView.scene.rootNode.addChildNode(boardNode)
    }
    
    /// Removes a node from the scene with animation if its a collision.
    func removeNodeWithAnimation(_ node: SCNNode, isCollision: Bool) {
        if isCollision {
            // Adding collision particle
            SoundManager.shared.playSound(sound: .collision)
            let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: nil)
            let systemNode = SCNNode()
            systemNode.addParticleSystem(particleSystem!)
            systemNode.position = node.position
            sceneView.scene.rootNode.addChildNode(systemNode)
        }
        // remove node
        node.removeFromParentNode()
    }
    
    /// Generates a random float between the given upper and lower bounds.
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
}
