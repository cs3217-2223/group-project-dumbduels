//
//  AXAnimationCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 26/3/23.
//

import DuelKit
import CoreGraphics

class AXAnimationCreator {
    func createPlayerHitAnimation(index: Int) -> AnimationComponent {
        let component = AnimationComponent(
            frames: [
                AnimationFrame(
                    frameDuration: 0.5,
                    spriteName: AXAssets.playerHit[index]),
                AnimationFrame(
                    frameDuration: 0.01,
                    spriteName: AXAssets.player[index])],
            numRepeat: 0,
            isPlaying: false
        )
        return component
    }

    func createAxeParticleAnimation() -> AnimationComponent {
        let component = AnimationComponent(
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0),
                AnimationFrame(
                    frameDuration: 0.55,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.15,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0)],
            numRepeat: 0,
            shouldDestroyEntityOnEnd: true
        )
        return component
    }

    func createLavaSmokeAnimation() -> AnimationComponent {
        var randomXDeltas = [CGFloat]()
        var randomYDeltas = [CGFloat]()

        for _ in 1...4 {
            let randomXDelta = CGFloat.random(in: -15...15)
            let randomYDelta = CGFloat.random(in: 20...50)
            randomXDeltas.append(randomXDelta)
            randomYDeltas.append(randomYDelta)
        }

        let component = AnimationComponent(
            frames: [
                AnimationFrame(
                    frameDuration: 0.01,
                    alpha: 0,
                    deltaPosition: CGPoint(x: 0, y: 0)),
                AnimationFrame(
                    frameDuration: 0.3,
                    alpha: 1,
                    deltaPosition: CGPoint(x: randomXDeltas[1], y: randomYDeltas[1])),
                AnimationFrame(
                    frameDuration: 0.3,
                    alpha: 0.5,
                    deltaPosition: CGPoint(x: randomXDeltas[2], y: randomYDeltas[2])),
                AnimationFrame(
                    frameDuration: 0.3,
                    alpha: 0,
                    deltaPosition: CGPoint(x: randomXDeltas[3], y: randomYDeltas[3]))],
            numRepeat: 0,
            shouldDestroyEntityOnEnd: true
        )
        return component
    }

}
