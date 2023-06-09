//
//  TAEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import Foundation
import DuelKit

class TAEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: TAPhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = TAPhysicsCreator()
    }

    @discardableResult
    func createTank(index: Int, at position: CGPoint, of size: CGSize) -> Entity {
        let tank = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            AutoRotateComponent(by: TAConstants.rotationSpeed)
            WillExplodeParticlesComponent(particles: TAAssets.particles[index])
            physicsCreator.createTank(of: size)
        }

        let fsm = EntityStateMachine<TankComponent.State>(entity: tank)

        fsm.createState(name: .charging0)
            .addInstance(SpriteComponent(assetName: TAAssets.tankSprite(index: index, charging: 0)))
        fsm.createState(name: .charging1)
            .addInstance(SpriteComponent(assetName: TAAssets.tankSprite(index: index, charging: 1)))
        fsm.createState(name: .charging2)
            .addInstance(SpriteComponent(assetName: TAAssets.tankSprite(index: index, charging: 2)))

        fsm.changeState(name: .charging0)

        tank.assign(component: TankComponent(index: index, fsm: fsm))

        tank.assign(component: ScoreComponent(for: index, withId: tank.id))

        let soundComponent = SoundComponent(sounds: [
            TASoundTypes.tankBeep: BeepSound(),
            TASoundTypes.tankEngine: EngineSound(),
            TASoundTypes.tankShoot: BulletSound()
        ])
        tank.assign(component: soundComponent)

        return tank
    }

    // swiftlint:disable function_parameter_count
    @discardableResult
    func createCannonball(at position: CGPoint, of size: CGSize,
                          direction: CGFloat, expiring expiryDate: Date,
                          firedBy playerId: EntityID, immunityUntil: Date) -> Entity {
        let ball = entityManager.createEntity {
            CannonballComponent(expiring: expiryDate, firedBy: playerId, immunityUntil: immunityUntil)
            PositionComponent(position: position)
            RotationComponent(angleInRadians: direction)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TAAssets.cannonball)
            physicsCreator.createCannonball(of: size, direction: direction)
        }

        let soundComponent = SoundComponent(sounds: [
            TASoundTypes.cannonballExtinguish: EngineSound()
        ])
        ball.assign(component: soundComponent)

        return ball
    }

    @discardableResult
    func createCannonballFire(of size: CGSize, ballId: EntityID) -> Entity {
        entityManager.createEntity {
            CannonballFireComponent(ballId: ballId)
            PositionComponent(position: .zero)
            RotationComponent(angleInRadians: .zero)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TAAssets.cannonballFire)
        }
    }

    @discardableResult
    func createWall(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TAAssets.wall)
            physicsCreator.createWall(of: size)
        }
    }

    @discardableResult
    func createSideWall(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            physicsCreator.createSideWall(of: size)
        }
    }
}
