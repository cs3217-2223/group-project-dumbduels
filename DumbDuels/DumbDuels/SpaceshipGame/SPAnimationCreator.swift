//
//  SPAnimationCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import Foundation
import DuelKit

class SPAnimationCreator {
    func createAccelerationParticle() -> AnimationComponent {
        let component = AnimationComponent(
            isPlaying: true,
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0),
                AnimationFrame(
                    frameDuration: 0.55,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0)],
            numRepeat: 0
        )
        return component
    }
}
