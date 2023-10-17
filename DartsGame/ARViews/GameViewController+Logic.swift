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
    
    func configureSession() {
        if ARWorldTrackingConfiguration.isSupported {
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        } else {
            // slightly less immersive AR experience due to lower end processor
            let configuration = AROrientationTrackingConfiguration()
            
            // Run the view's session
            sceneView.session.run(configuration)
        }
    }
    
    func throwDart() {
        self.playSoundEffect(ofType: .torpedo)
        let dartsNode = Dart()
        let (direction, position) = self.getUserVector()
        dartsNode.position = position
        let dartsDirection = direction
        dartsNode.physicsBody?.applyForce(dartsDirection, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(dartsNode)
    }
    
    func addNewBoard() {
        let boardNode = DartBoard()
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5  )
        boardNode.position = SCNVector3(posX, posY, -1) // SceneKit/AR coordinates are in meters
        sceneView.scene.rootNode.addChildNode(boardNode)
    }
    
    func removeNodeWithAnimation(_ node: SCNNode, explosion: Bool) {
        
        // Play collision sound for all collisions (bullet-bullet, etc.)
        
        self.playSoundEffect(ofType: .collision)
        
        if explosion {
            
            // Play explosion sound for bullet-ship collisions
            
            self.playSoundEffect(ofType: .explosion)
            
            let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: nil)
            let systemNode = SCNNode()
            systemNode.addParticleSystem(particleSystem!)
            // place explosion where node is
            systemNode.position = node.position
            sceneView.scene.rootNode.addChildNode(systemNode)
        }
        
        // remove node
        node.removeFromParentNode()
    }
    
    func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound (inclusive)
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    // MARK: - Sound Effects
    // todo: create sound manager and change sounds
    
    func playSoundEffect(ofType effect: SoundEffect) {
        // Async to avoid substantial cost to graphics processing (may result in sound effect delay however)
        DispatchQueue.main.async {
            do
            {
                if let effectURL = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3") {
                    
                    self.player = try AVAudioPlayer(contentsOf: effectURL)
                    self.player.play()
                }
            }
            catch let error as NSError {
                print(error.description)
            }
        }
    }
}