//
//  PlayerSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class PlayerSystem: System {
    unowned var entityManager: EntityManager

    private var cannotJumpPlayer: Assemblage2<PlayerComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannotJumpPlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PhysicsComponent.self,
            excludedComponents: CanJumpComponent.self)
    }

    func update() {

    }

    func possibleLand(playerId: EntityID ) {
        guard let (_, physics) = cannotJumpPlayer.getComponents(for: playerId),
              physics.velocity.dy <= 0 else {
            return
        }
        entityManager.assign(component: CanJumpComponent(), to: playerId)
    }

}
