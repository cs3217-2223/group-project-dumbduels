//
//  EntityManager.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation
public final class EntityManager {

    internal var componentsByType: [ComponentTypeID: [ComponentID: Component]]

    internal var entityComponentMap: [EntityID: Set<Pair<ComponentTypeID, ComponentID>>]

    internal var assemblageEntityMap: [TraitSet: Set<EntityID>]

    convenience init() {
        self.init(componentsByType: [:], entityComponentMap: [:], assemblageEntityMap: [:])
    }

    internal init(componentsByType: [ComponentTypeID: [ComponentID: Component]],
                  entityComponentMap: [EntityID: Set<Pair<ComponentTypeID, ComponentID>>],
                  assemblageEntityMap: [TraitSet: Set<EntityID>]) {
        self.componentsByType = componentsByType
        self.entityComponentMap = entityComponentMap
        self.assemblageEntityMap = assemblageEntityMap
    }

    deinit {
        clear()
    }

    final func clear() {
        componentsByType.removeAll()
        entityComponentMap.removeAll()
        assemblageEntityMap.removeAll()
    }
}

extension EntityManager: CustomDebugStringConvertible {
    public var debugDescription: String {
        "EntityManager entities: \(numEntities) component: \(numComponents) families: \(numAssemblages)"
    }
}
