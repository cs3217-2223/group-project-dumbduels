//
//  SPEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit
import Foundation

class SPEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: SPPhysicsCreator
    private let animationCreator: SPAnimationCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = SPPhysicsCreator()
        self.animationCreator = SPAnimationCreator()
    }

    @discardableResult
    func createSpaceship(index: Int, at position: CGPoint, of size: CGSize,
                         score: Int = 0) -> Entity {
        let spaceship = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            AutoRotateComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "spaceship\(index)")
            SpaceshipComponent(index: index)
            physicsCreator.createSpaceship(of: size)
        }

        // Bing Sen TODO: Can remove entityId for score component since we using index now
        spaceship.assign(component: ScoreComponent(score: score, for: spaceship.id))

        return spaceship
    }

    @discardableResult
    func createRock(at position: CGPoint, angle: CGFloat, justActivatedBy playerId: EntityID) -> Entity {
        let size = SPSizes.rock
        let rock = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "rock")
            RockComponent(justActivatedBy: playerId)
            physicsCreator.createRock(of: size, pointing: angle)
        }
        return rock
    }

    @discardableResult
    func createBullet(index: Int, from playerId: EntityID, angle: CGFloat, position: CGPoint,
                      lifespan: TimeInterval = SPConstants.bulletLifespan) -> Entity {
        let size = SPSizes.bullet
        // index is needed so I know what colour sprite to attach
        // playerId is needed so I know who fired it (if get hit by own bullet, is ok)
        let bullet = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent(angleInRadians: angle)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "bullet\(index)")
            BulletComponent(for: playerId, lifespan: lifespan)
            physicsCreator.createBullet(of: size, pointing: angle)
        }
        return bullet
    }

    @discardableResult
    func createPowerup() -> Entity {
        let size = SPSizes.powerup
        let position = CGPoint.random(within: Sizes.game)

        let powerup = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            physicsCreator.createPowerup(of: size)
        }

        let powerupComponents: [[Component]] = [
//            [
//                SpriteComponent(assetName: "gunPowerup"),
//                PowerupComponent(ofType: GunPowerup())
//            ],
            [
                SpriteComponent(assetName: "bombPowerup"),
                PowerupComponent(ofType: BombPowerup())
            ]
        ]

        for comp in powerupComponents.randomElement()! {
            powerup.assign(component: comp)
        }

        return powerup
    }

    @discardableResult
    func createAccelerationParticle(at position: CGPoint, of size: CGSize) -> Entity {
        let particle = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.lava)
        }

        let animationComponent = animationCreator.createAccelerationParticle()
        particle.assign(component: animationComponent)

        return particle
    }

    @discardableResult
    func createSpaceshipParticle(at position: CGPoint, of size: CGSize, sprite: String,
                                 deltaPosition: CGPoint, travelTime: CGFloat) -> Entity {
        let spaceshipParticle = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: sprite)
        }
        let animationComponent = animationCreator.createSpaceshipParticleAnimation(
            deltaPosition: deltaPosition, travelTime: travelTime)
        spaceshipParticle.assign(component: animationComponent)

        return spaceshipParticle
    }

    @discardableResult
    func createBattleText(at position: CGPoint, of size: CGSize) -> Entity {
        let battleText = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.battleText)
        }
        let animationComponent = animationCreator.createBattleFlashAnimation()
        battleText.assign(component: animationComponent)

        return battleText
    }
}
