//
//  Collisions.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class AXCollisions {
    static let playerBitmask: UInt32 = 0x1 << 0
    static let axeBitmask: UInt32 = 0x1 << 1
    static let platformBitmask: UInt32 = 0x1 << 2
    static let pegBitmask: UInt32 = 0x1 << 3
    static let axeParticleBitmask: UInt32 = 0x1 << 4
    static let lavaBitmask: UInt32 = 0x1 << 5
    static let wallBitmask: UInt32 = 0x1 << 6

    static let playerCollideBitmask: UInt32 = platformBitmask | wallBitmask
    static let axeCollideBitmask: UInt32 = axeBitmask | pegBitmask | wallBitmask
    static let platformCollideBitmask: UInt32 = playerBitmask | wallBitmask
    static let pegCollideBitmask: UInt32 = axeBitmask | wallBitmask
    static let lavaCollideBitmask: UInt32 = 0x0
    static let wallCollideBitmask: UInt32 = playerBitmask | axeBitmask | platformBitmask | pegBitmask
    static let axeParticleCollideBitmask: UInt32 = 0x0

    static let playerContactBitmask: UInt32 = axeBitmask | platformBitmask | wallBitmask
    static let axeContactBitmask: UInt32 = playerBitmask | axeBitmask | pegBitmask | lavaBitmask | wallBitmask
    static let platformContactBitmask: UInt32 = playerBitmask | wallBitmask
    static let pegContactBitmask: UInt32 = axeBitmask | wallBitmask
    static let lavaContactBitmask: UInt32 = axeBitmask
    static let wallContactBitmask: UInt32 = playerBitmask | axeBitmask | platformBitmask | pegBitmask
    static let axeParticleContactBitmask: UInt32 = 0x0

    private static func unionBitmasks(_ bitmasks: [UInt32]) -> UInt32 {
        var result: UInt32 = 0x00000000
        for bitmask in bitmasks {
            result = result | bitmask
        }
        return result
    }
}
