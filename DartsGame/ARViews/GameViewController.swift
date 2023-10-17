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
    
    var sceneView: ARSCNView!
    var scoreLabel: UILabel!
    var player: AVAudioPlayer!
    private var cancellables: Set<AnyCancellable> = []
    
    var userScore: Int = 0 {
        didSet {
            // ensure UI update runs on main thread
            DispatchQueue.main.async {
                self.scoreLabel.text = String(self.userScore)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView()
        sceneView.delegate = self
        //sceneView.showsStatistics = true
        view.addSubview(sceneView)
        
        sceneView.scene = SCNScene()
        sceneView.scene.physicsWorld.contactDelegate = self
        // todo: remove score label and pass to swiftui view through delegate
        scoreLabel = UILabel()
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.textColor = UIColor.white
        view.addSubview(scoreLabel)
        self.userScore = 0
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
        scoreLabel.frame = CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 50)
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
