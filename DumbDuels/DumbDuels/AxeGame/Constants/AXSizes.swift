//
//  AXSizes.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics
import DuelKit

struct AXSizes {
    static let player = CGSize(width: 80, height: 80)
    static let axe = CGSize(width: 40, height: 40)
    static let platform = CGSize(width: 200, height: 50)
    static let walls = [CGSize(width: 1, height: Sizes.game.height),
                        CGSize(width: 1, height: Sizes.game.height),
                        CGSize(width: Sizes.game.width, height: 1)]
    static let peg = CGSize(width: 30, height: 30)
    static let lava = CGSize(width: Sizes.game.width, height: 70)
    static let particle = CGSize(width: 10, height: 10)

    static func axeOffsetFromPlayer(facing direction: FaceDirection) -> CGFloat {
        (player.width / 2 + axe.height / 2 + 10) * direction.rawValue
    }
}
