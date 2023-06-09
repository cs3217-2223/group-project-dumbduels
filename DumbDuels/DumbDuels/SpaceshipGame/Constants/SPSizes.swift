//
//  SPSizes.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

struct SPSizes {
    static let spaceship = CGSize(width: 80, height: 60)
    static let rock = CGSize(width: 60, height: 60)
    static let bullet = CGSize(width: 40, height: 10)
    static let powerup = CGSize(width: 60, height: 60)
    static let accelerationParticle = CGSize(width: 8, height: 8)
    static let spaceshipDestroyParticle = CGSize(width: 10, height: 10)
    static let star = CGSize(width: 11, height: 11)

    static func randomSpaceshipPositions() -> (CGPoint, CGPoint) {
        Positions.random2(withBuffer: max(spaceship.width, spaceship.height))
    }
}
