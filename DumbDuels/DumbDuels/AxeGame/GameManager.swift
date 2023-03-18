//
//  GameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

class GameManager {
    private let renderSystemDetails: RenderSystemDetails

    private let entityManager: EntityManager
    private let entityCreator: EntityCreator

    private let systemManager: SystemManager
    private let eventManager: EventManager

    private let simulator: Simulator

    init(renderSystemDetails: RenderSystemDetails) {
        self.renderSystemDetails = renderSystemDetails

        let entityManager = EntityManager()
        let entityCreator = EntityCreator(entityManager: entityManager)
        self.entityManager = entityManager
        self.entityCreator = entityCreator

        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)
        self.systemManager = systemManager
        self.eventManager = eventManager

        self.simulator = Simulator()

        setUpEntities()
        setUpSystems()
        startGame()
    }

    private func setUpEntities() {
        for playerIndex in 0...1 {
            let playerPosition = Positions.players[playerIndex]
            let faceDirection: FaceDirection = playerIndex == 0 ? .right : .left

            let verticalOffset = (Sizes.player.height / 2 + Sizes.platform.height / 2) * -1
            let platform = entityCreator.createPlatform(
                withVerticalOffset: verticalOffset,
                from: playerPosition,
                of: Sizes.platform
            )

            let horizontalOffset = (Sizes.player.width / 2 + Sizes.axe.height / 2) * faceDirection.rawValue
            let axe = entityCreator.createAxe(
                withHorizontalOffset: horizontalOffset,
                from: playerPosition,
                of: Sizes.axe
            )

            let player = entityCreator.createPlayer(
                at: playerPosition,
                facing: faceDirection,
                of: Sizes.player,
                holding: axe.id
            )
            renderSystemDetails.gameController.registerPlayerID(playerIndex: playerIndex, playerEntityID: player.id)
        }
    }

    private func setUpSystems() {
        systemManager.register(InputSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(RoundSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(PhysicsSystem(
            for: entityManager,
            eventManager: eventManager,
            scene: simulator.gameScene
        ))
        systemManager.register(ScoreSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(RenderSystem(
            for: entityManager,
            eventManger: eventManager,
            details: renderSystemDetails
        ))
    }

    private func updateSystems() {
        systemManager.update()
    }

    private func startGame() {
        // TODO: replace with physics system, this is for display initial positions (for testing only)
        guard let renderSystem = systemManager.get(ofType: RenderSystem.self) else {
            return
        }
        renderSystem.update()
    }
}

// MARK: - Handle Input
extension GameManager {
    func handleButtonPress(for entityID: EntityID) {
        eventManager.fire(ButtonPressEvent(entityId: entityID))
    }

    func handleButtonLongPress(for entityID: EntityID) {

    }
}

// MARK: - GameSceneDelegate
extension GameManager: GameSceneDelegate {
    func gameLoopDidStart() {

    }

    func update(with timeInterval: Double) {

    }

    func didSimulatePhysics() {

    }

    func didFinishUpdate() {
//        1. sync the physics engine to the physics system
//        2. Poll all events
//        3. Sync from physics system to physics engine
//        4. Render
    }
}
