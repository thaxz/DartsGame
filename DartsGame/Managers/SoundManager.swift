//
//  SoundManager.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    private init () {}
    
    var player: AVAudioPlayer?
    
    func playSoundEffect(ofType effect: SoundEffect) {
        let url = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3")
        guard url != nil else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.setVolume(1.5, fadeDuration: 0.1)
            player?.play()
        } catch {
            print("erro tocando efeito sonoro")
        }
    }
    
    func playSoundtrack(sound: SoundEffect) {
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
