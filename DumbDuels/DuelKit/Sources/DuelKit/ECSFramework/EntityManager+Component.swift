//
//  EntityManager+Component.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

extension EntityManager {
    var numComponents: Int {
        componentsByType.reduce(0) {
            $0 + $1.value.keys.count
        }
    }

    public func has(componentTypeId: ComponentTypeID, entityId: EntityID) -> Bool {
        guard let allComponentsOfEntity = entityComponentMap[entityId] else {
            return false
        }

        return allComponentsOfEntity.contains { $0.first == componentTypeId }
    }

    public func countComponents(for entityId: EntityID) -> Int {
        entityComponentMap[entityId]?.count ?? 0
    }

    @discardableResult
    public func assign<C>(components: C, to entity: Entity) -> Bool where C: Collection, C.Element == Component {
        assign(components: components, to: entity.id)
    }

    @discardableResult
    public func assign(component: Component, to entity: Entity) -> Bool {
        assign(component: component, to: entity.id)
    }

    public func getComponent<C>(ofType componentType: ComponentTypeID,
                                for entityId: EntityID) -> C? where C: Component {
        let component = get(componentType: componentType, for: entityId)
        guard let component else {
            // entity has no such component
            return nil
        }
        guard let typedCastComponent = component as? C else {
            // should never reach here
            assertionFailure("Component of type \(componentType) cannot be cast")
            return nil
        }
        return typedCastComponent
    }

    /**
     * Same as getComponent(ofType:for), but used when compiler can infer the concrete type of C from usage context
     * Example:
     * - position: PositionComponent = entityManager.get(for: entityId)
     */
    public func getComponent<C>(for entityId: EntityID) -> C? where C: Component {
        getComponent(ofType: C.typeId, for: entityId)
    }

    public func getAllComponentTypes(for entityId: EntityID) -> Set<ComponentTypeID>? {
        let componentTypes = entityComponentMap[entityId]?.map { $0.first }
        guard let componentTypes else {
            return nil
        }
        return Set(componentTypes)
    }

    public func remove(componentType: ComponentTypeID, from entityId: EntityID) {
        guard let component = get(componentType: componentType, for: entityId) else {
            return
        }
        componentsByType[component.typeId]?.removeValue(forKey: component.id)
        let componentReference = Pair(component.typeId, component.id)
        let isSuccess = entityComponentMap[entityId]?.remove(componentReference)

        assert(isSuccess != nil, "Component reference not removed from entity-to-component map")
        updateAssemblageMembership(for: entityId)
    }

    // TODO: Will rewriting this without using remove() make it faster because update is not done repeatedly?
    public func removeAllComponents(for entityId: EntityID) {
        guard let allComponentTypes = getAllComponentTypes(for: entityId) else {
            return
        }
        for componentType in allComponentTypes {
            remove(componentType: componentType, from: entityId)
        }
    }

    private func get(componentType: ComponentTypeID, for entityId: EntityID) -> Component? {
        let nilableComponentReference = entityComponentMap[entityId]?.first { $0.first == componentType }
        guard let nilableComponentReference else {
            return nil
        }
        let componentTypeId = nilableComponentReference.first
        let componentInstanceId = nilableComponentReference.second
        return componentsByType[componentTypeId]?[componentInstanceId]
    }
}
