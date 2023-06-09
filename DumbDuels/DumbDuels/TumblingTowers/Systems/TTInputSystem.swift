//
//  TTInputSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import Foundation
import DuelKit

class TTInputSystem: InputSystem {
    private let longPressThreshold = 0.2
    private let entityManager: EntityManager
    // A map that maps the index of buttons to its last press time, and for which blockId
    // Tracking which blockId is important, because there might be many cases
    private var longPressStartTimes = [Int: Pair<Date, EntityID>]()
    private let players: Assemblage2<TTPlayerComponent, ScoreComponent>
    private let controlBlocks: Assemblage6<
        BlockComponent, HasGuidelineComponent, PositionComponent,
        SizeComponent, RotationComponent, PhysicsComponent>

    var playerIndexToIdMap = [Int: EntityID]()
    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.players = entityManager.assemblage(requiredComponents: TTPlayerComponent.self, ScoreComponent.self)
        self.controlBlocks = entityManager.assemblage(
            requiredComponents: BlockComponent.self,
            HasGuidelineComponent.self, PositionComponent.self,
            SizeComponent.self, RotationComponent.self, PhysicsComponent.self)
    }

    func update() {
        for (key, value) in longPressStartTimes {
            let timePressed = Date() - value.first
            if timePressed <= longPressThreshold {
                continue
            }
            guard let (block, _, position, size, _, _) = controlBlocks.getComponents(for: value.second) else {
                longPressStartTimes[key] = nil
                return
            }

            position.position.x += block.movingDirection * TTConstants.blockXVelocity
            let blockFrame = CGRect(origin: CGPoint(x: position.position.x - size.actualSize.width / 2,
                                                    y: position.position.y - size.actualSize.height / 2),
                                    size: size.actualSize)
            let playerFrame = TTPositions.playerRanges[key]
            if !playerFrame.contains(blockFrame) {
                block.movingDirection *= -1
                position.position.x += block.movingDirection * TTConstants.blockXVelocity
            }
        }
    }

    func handleButtonDown(playerIndex: Int) {
        guard let playerId = playerIndexToIdMap[playerIndex],
              let (player, _) = players.getComponents(for: playerId),
              let currentBlockId = player.currentControllingBlockId else {
            return
        }
        longPressStartTimes[playerIndex] = Pair(Date(), currentBlockId)
    }

    func handleButtonUp(playerIndex: Int) {
        guard let mapValue = longPressStartTimes[playerIndex] else {
            return
        }
        let timePressed = Date() - mapValue.first
        // We only handle "tap" cases here, as long press cases are done inside update function
        if timePressed <= longPressThreshold {
            rotateBlock(blockId: mapValue.second)
        } else {
            // if it's a long press, we change direction for the next press
            changeMovingDirection(for: mapValue.second)
        }
        longPressStartTimes.removeValue(forKey: playerIndex)
    }

    func removePressMapping(controlBlockId: EntityID) {
        guard let (block, _, _, _, _, _) = controlBlocks.getComponents(for: controlBlockId),
              let (player, _) = players.getComponents(for: block.playerId),
              let mapValue = longPressStartTimes[player.index],
                  mapValue.second == controlBlockId else { // Important to check because it might be different already
            return
        }

        longPressStartTimes.removeValue(forKey: player.index)
    }

    private func rotateBlock(blockId: EntityID) {
        guard let (block, _, _, _, rotation, _) = controlBlocks
            .getComponents(for: blockId) else {
            return
        }
        rotation.angleInRadians = (rotation.angleInRadians + Double.pi / 2)
            .truncatingRemainder(dividingBy: 2 * Double.pi)

        block.useWidthForGuideline.toggle()
    }

    private func changeMovingDirection(for blockId: EntityID) {
        guard let (block, _, _, _, _, _) = controlBlocks
            .getComponents(for: blockId) else {
            return
        }
        block.movingDirection *= -1
    }

    func handleGameOver() {
        longPressStartTimes.removeAll()
        for (_, _, _, _, _, physics) in controlBlocks {
            physics.velocity.dx = 0
        }
    }
}
