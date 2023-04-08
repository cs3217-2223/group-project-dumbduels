//
//  SoundSystem.swift
//
//
//  Created by Esmanda Wong on 7/4/23.
//

import AVFoundation

public class SoundSystem: NSObject, AVAudioPlayerDelegate, System {
    unowned var entityManager: EntityManager

    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []
    var sounds: Assemblage1<SoundComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.sounds = entityManager.assemblage(requiredComponents: SoundComponent.self)
    }

    public func update() {
        for (soundComponent) in sounds {
            for sound in soundComponent.sounds.values {
                guard sound.isPlaying,
                      let player = getAudioPlayer(for: sound.url) else {
                    continue
                }
                player.play()
                sound.stop()
            }
        }
    }

    private func getAudioPlayer(for url: URL) -> AVAudioPlayer? {
        guard let player = players[url] else {
            let player = try? AVAudioPlayer(contentsOf: url)
            players[url] = player
            return player
        }

        guard player.isPlaying else {
            return player
        }

        guard let duplicatePlayer = try? AVAudioPlayer(contentsOf: url) else { return nil }
        duplicatePlayer.delegate = self
        duplicatePlayers.append(duplicatePlayer)
        return duplicatePlayer
    }

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        duplicatePlayers.removeAll { $0 == player }
    }
}
