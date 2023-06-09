//
//  PhysicsComponent.swift
//  DuelKit
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

public class PhysicsComponent: Component {
    public enum Shape {
        case circle
        case rectangle
    }

    public var id: ComponentID
    public var shape: Shape
    public var radius: CGFloat?
    public var size: CGSize?
    public var mass: CGFloat
    public var velocity: CGVector
    public var affectedByGravity: Bool
    public var linearDamping: CGFloat
    public var isDynamic: Bool
    public var allowsRotation: Bool
    public var restitution: CGFloat
    public var friction: CGFloat
    public var zRotation: CGFloat
    public var impulse: CGVector
    public var angularImpulse: CGFloat
    public var ownBitmask: UInt32
    public var collideBitmask: UInt32
    public var contactBitmask: UInt32
    public var toBeRemoved: Bool
    public var shouldDestroyEntityWhenRemove: Bool

    private init?(shape: Shape, mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                  linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                  restitution: CGFloat, friction: CGFloat, ownBitmask: UInt32,
                  collideBitmask: UInt32, contactBitmask: UInt32,
                  zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat,
                  radius: CGFloat? = nil, size: CGSize? = nil,
                  toBeRemoved: Bool = false, shouldDestroyEntityWhenRemove: Bool = false) {
        guard (size == nil && radius != nil) || (size != nil && radius == nil) else {
            assertionFailure(
                """
                Please pass in only either a size for a rectangle physics component
                or a radius for a circle physics component
                """
            )
            return nil
        }
        guard mass > 0 else {
            assertionFailure("Mass cannot be negative")
            return nil
        }
        guard linearDamping >= 0 && linearDamping <= 1 else {
            assertionFailure("linearDamping must be a value from 0.0 to 1.0")
            return nil
        }
        guard restitution >= 0 && restitution <= 1 else {
            assertionFailure("restitution must be a value from 0.0 to 1.0")
            return nil
        }
        guard friction >= 0 && linearDamping <= 1 else {
            assertionFailure("friction must be a value from 0.0 to 1.0")
            return nil
        }

        self.id = ComponentID()
        self.shape = shape
        self.radius = radius
        self.size = size
        self.mass = mass
        self.velocity = velocity
        self.affectedByGravity = affectedByGravity
        self.linearDamping = linearDamping
        self.isDynamic = isDynamic
        self.allowsRotation = allowsRotation
        self.restitution = restitution
        self.friction = friction
        self.zRotation = zRotation
        self.impulse = impulse
        self.angularImpulse = angularImpulse
        self.ownBitmask = ownBitmask
        self.collideBitmask = collideBitmask
        self.contactBitmask = contactBitmask
        self.toBeRemoved = toBeRemoved
        self.shouldDestroyEntityWhenRemove = shouldDestroyEntityWhenRemove
    }

    public convenience init(circleOf radius: CGFloat, with details: PhysicsDetails) {
        self.init(shape: .circle, mass: details.mass, velocity: details.velocity,
                  affectedByGravity: details.affectedByGravity, linearDamping: details.linearDamping,
                  isDynamic: details.isDynamic, allowsRotation: details.allowsRotation,
                  restitution: details.restitution, friction: details.friction, ownBitmask: details.ownBitmask,
                  collideBitmask: details.collideBitmask, contactBitmask: details.contactBitmask,
                  zRotation: details.zRotation, impulse: details.impulse, angularImpulse: details.angularImpulse,
                  radius: radius, size: nil)!
    }

    public convenience init(rectangleOf size: CGSize, with details: PhysicsDetails) {
        self.init(shape: .rectangle, mass: details.mass, velocity: details.velocity,
                  affectedByGravity: details.affectedByGravity, linearDamping: details.linearDamping,
                  isDynamic: details.isDynamic, allowsRotation: details.allowsRotation,
                  restitution: details.restitution, friction: details.friction, ownBitmask: details.ownBitmask,
                  collideBitmask: details.collideBitmask, contactBitmask: details.contactBitmask,
                  zRotation: details.zRotation, impulse: details.impulse, angularImpulse: details.angularImpulse,
                  radius: nil, size: size)!
    }
}
