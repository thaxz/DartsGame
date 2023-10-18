//
//  CustomARView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

// MARK: Custom ARKit view controller for handling the game logic and rendering.

class GameViewController: UIViewController, ARSCNViewDelegate {
    
    var gameLogicDelegate: GameLogicDelegate? = nil
    
    var sceneView: ARSCNView!
    var player: AVAudioPlayer!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView()
        sceneView.delegate = self
        view.addSubview(sceneView)
        sceneView.scene = SCNScene()
        sceneView.scene.physicsWorld.contactDelegate = self
        self.addNewBoard()
        self.subscribeToActionStream()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.frame = view.bounds
    }
    
    // MARK: - Combine
    /// Subscribes to the ARManager's actions stream to handle different AR actions.
    func subscribeToActionStream(){
        ARManager.shared.actionsStream
            .sink { [weak self] action in
                switch action {
                case .placeDart:
                    self?.throwDart()
                case .pause:
                    self?.sceneView.session.pause()
                case .play:
                    self?.sceneView.session.run(ARWorldTrackingConfiguration())
                }
            }
            .store(in: &cancellables)
    }
    
}

// MARK: Delegate

extension GameViewController {
    
    /// Handles adding points through the game logic delegate.
    func addPoint() {
        if var gameLogicDelegate = self.gameLogicDelegate {
            gameLogicDelegate.addPoint()
        }
    }
}
