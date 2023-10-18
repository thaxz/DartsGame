//
//  ARManager.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import Combine
import RealityKit

// Manager class to control AR-related actions
class ARManager {
   
    /// Singleton
    static let shared = ARManager()
    private init () {}
    
    /// PassthroughSubject object used to publish AR actions to any object that subscribed to it
    var actionsStream = PassthroughSubject<ARAction, Never>()
}
