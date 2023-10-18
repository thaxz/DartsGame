//
//  SoundManager.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import Foundation
import AVFoundation

// MARK: A singleton class responsible for managing audio playback
class SoundManager {
    
    static let shared = SoundManager()
    private init () {}
    
    var player: AVAudioPlayer?
    
    /// Plays a specified sound effect.
    /// - Parameter sound: The type of sound effect to be played.
    func playSound(sound: SoundType) {
        let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3")
        guard url != nil else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.setVolume(1.5, fadeDuration: 0.1)
            player?.play()
        } catch {
            print("erro tocando efeito sonoro")
        }
    }
    
    /// Plays a specified soundtrack in a loop.
    /// - Parameter sound: The type of soundtrack to be played.
    func playSoundtrack(sound: SoundType) {
        let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3")
        guard url != nil else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.setVolume(0.3, fadeDuration: 0.1)
            player?.play()
            player?.numberOfLoops = -1
        } catch {
            print("erro tocando soundtrack")
        }
    }
    
}
