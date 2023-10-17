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

class GameViewController: UIViewController, ARSCNViewDelegate {
    
    var gameLogicDelegate: GameLogicDelegate? = nil
    
    var sceneView: ARSCNView!
    var player: AVAudioPlayer!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView()
        sceneView.delegate = self
        //sceneView.showsStatistics = true
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
    
    // MARK: Combine
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
    
    func addPoint() {
        if var gameLogicDelegate = self.gameLogicDelegate {
            gameLogicDelegate.addPoint()
        }
    }
}
