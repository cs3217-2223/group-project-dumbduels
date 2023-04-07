//
//  TAPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class TAPhysicsCreator {
    func createTank(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: TAPhysics.tankMass,
                         velocity: .zero,
                         affectedByGravity: TAPhysics.tankGravity,
                         linearDamping: TAPhysics.tankStaticDamping,
                         isDynamic: TAPhysics.tankIsDynamic,
                         allowsRotation: TAPhysics.tankRotation,
                         restitution: TAPhysics.tankCor,
                         friction: TAPhysics.tankFriction,
                         ownBitmask: TACollisions.tankBitmask,
                         collideBitmask: TACollisions.tankCollideBitmask,
                         contactBitmask: TACollisions.tankContactBitmask,
                         zRotation: TAPhysics.tankZRotation,
                         impulse: TAPhysics.tankImpulse,
                         angularImpulse: TAPhysics.tankAngularImpulse)
    }

    func createCannonball(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(circleOf: size.height / 2,
                         mass: TAPhysics.cannonballMass,
                         velocity: .zero,
                         affectedByGravity: TAPhysics.cannonballGravity,
                         linearDamping: TAPhysics.cannonballStaticDamping,
                         isDynamic: TAPhysics.cannonballIsDynamic,
                         allowsRotation: TAPhysics.cannonballRotation,
                         restitution: TAPhysics.cannonballCor,
                         friction: TAPhysics.cannonballFriction,
                         ownBitmask: TACollisions.cannonballBitmask,
                         collideBitmask: TACollisions.cannonballCollideBitmask,
                         contactBitmask: TACollisions.cannonballContactBitmask,
                         zRotation: TAPhysics.cannonballZRotation,
                         impulse: TAPhysics.cannonballImpulse,
                         angularImpulse: TAPhysics.cannonballAngularImpulse)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: TAPhysics.wallMass,
                         velocity: .zero,
                         affectedByGravity: TAPhysics.wallGravity,
                         linearDamping: TAPhysics.wallStaticDamping,
                         isDynamic: TAPhysics.wallIsDynamic,
                         allowsRotation: TAPhysics.wallRotation,
                         restitution: TAPhysics.wallCor,
                         friction: TAPhysics.wallFriction,
                         ownBitmask: TACollisions.wallBitmask,
                         collideBitmask: TACollisions.wallCollideBitmask,
                         contactBitmask: TACollisions.wallContactBitmask,
                         zRotation: TAPhysics.wallZRotation,
                         impulse: TAPhysics.wallImpulse,
                         angularImpulse: TAPhysics.wallAngularImpulse)
    }
}
