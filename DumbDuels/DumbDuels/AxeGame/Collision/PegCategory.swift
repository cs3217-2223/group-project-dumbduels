//
//  PegCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct PegCategory: CollisionCategory {

    var entityId: EntityID
    let ownBitmask: UInt32 = ColliisionUtils.pegBitmask
    let collideBitmask: UInt32 = ColliisionUtils.pegCollideBitmask
    let contactBitmask: UInt32 = ColliisionUtils.pegContactBitmask

    init(entityId: EntityID) {
        self.entityId = entityId
    }

    func collides(with otherCategory: CollisionCategory) -> Event? {
        otherCategory.collides(with: self)
    }

    func collides(with player: PlayerCategory) -> Event? {
        nil
    }

    func collides(with axe: AxeCategory) -> Event? {
        nil
    }

    func collides(with platform: PlatformCategory) -> Event? {
        nil
    }

    func collides(with peg: PegCategory) -> Event? {
        nil
    }
}
