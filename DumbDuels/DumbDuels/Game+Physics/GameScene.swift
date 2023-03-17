//
//  GameScene.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

public typealias BodyID = String

public class GameScene {
    private(set) var baseGameScene: BaseGameScene
    public private(set) var bodyIDPhysicsMap: [BodyID: PhysicsBody]
    public private(set) var physicsBodyIDMap: [PhysicsBody: BodyID]
    private var skNodePhysicsBodyMap: [SKNode: PhysicsBody]

    public var gameSceneDelegate: GameSceneDelegate? {
        get { baseGameScene.gameSceneDelegate }
        set { baseGameScene.gameSceneDelegate = newValue }
    }

    public var physicsContactDelegate: PhysicsContactDelegate? {
        get { baseGameScene.physicsContactDelegate }
        set { baseGameScene.physicsContactDelegate = newValue }
    }

    public init() {
        guard let baseGameScene = BaseGameScene(fileNamed: "BaseGameScene") else {
            fatalError("BaseGameScene failed to load.")
        }
        self.baseGameScene = baseGameScene
        self.baseGameScene.delegate = self.baseGameScene
        self.bodyIDPhysicsMap = [:]
        self.physicsBodyIDMap = [:]
        self.skNodePhysicsBodyMap = [:]
        self.baseGameScene.gameScene = self
    }

    public func setup(newBodyIDPhysicsMap: [BodyID: PhysicsBody]) {
        self.baseGameScene.removeAllChildren()
        self.bodyIDPhysicsMap = [:]
        self.physicsBodyIDMap = [:]
        self.skNodePhysicsBodyMap = [:]
        for (bodyID, physicsBody) in newBodyIDPhysicsMap {
            baseGameScene.addChild(physicsBody.node)
            bodyIDPhysicsMap[bodyID] = physicsBody
            physicsBodyIDMap[physicsBody] = bodyID
            skNodePhysicsBodyMap[physicsBody.node] = physicsBody
        }
    }

    public func addBody(for id: BodyID, bodyToAdd: PhysicsBody) {
        guard baseGameScene.nodes(at: bodyToAdd.position).isEmpty,
              bodyIDPhysicsMap[id] == nil,
              physicsBodyIDMap[bodyToAdd] == nil,
              skNodePhysicsBodyMap[bodyToAdd.node] == nil else {
            assertionFailure("Trying to add an id that already exists.")
            return
        }
        baseGameScene.addChild(bodyToAdd.node)
        bodyIDPhysicsMap[id] = bodyToAdd
        physicsBodyIDMap[bodyToAdd] = id
        skNodePhysicsBodyMap[bodyToAdd.node] = bodyToAdd
    }

    public func removeBody(for id: BodyID) {
        guard let physicsBody = bodyIDPhysicsMap.removeValue(forKey: id),
              bodyIDPhysicsMap.removeValue(forKey: physicsBody) != nil,
              skNodePhysicsBodyMap.removeValue(forKey: physicsBody.node) != nil else {
            assertionFailure("Trying to remove an id that does not exist.")
            return
        }
        baseGameScene.removeChildren(in: [physicsBody.node])
    }

    func getBodyID(for skPhysicsBody: SKPhysicsBody) -> BodyID? {
        if let skNode = skPhysicsBody.node,
           let physicsBody = skNodePhysicsBodyMap[skNode],
           let bodyID = physicsBodyIDMap[physicsBody],
           bodyIDPhysicsMap[bodyID] == physicsBody {
            return bodyID
        }
        assertionFailure("Could not find corresponding BodyID for SKPhysicsBody")
        return nil
    }

    public func apply(impulse: CGVector, to id: BodyID) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              physicsBodyIDMap[physicsBody] != nil,
              skNodePhysicsBodyMap[physicsBody.node] != nil else {
            assertionFailure("Trying to apply impulse to an id that does not exist.")
            return
        }
        physicsBody.applyImpulse(impulse)
    }

    public func sync(updatedBodyIDPhysicsMap: [BodyID: PhysicsBody]) {
        for (id, physicsBody) in updatedBodyIDPhysicsMap {
            guard bodyIDPhysicsMap[id] != nil,
                  physicsBodyIDMap[physicsBody] != nil,
                  skNodePhysicsBodyMap[physicsBody.node] != nil else {
                assertionFailure("Trying to sync for an id that does not exist.")
                continue
            }
            bodyIDPhysicsMap[id]?.updateWith(newPhysicsBody: physicsBody)
        }
    }

    public func sync(_ physicsBody: PhysicsBody, for id: BodyID) {
        guard bodyIDPhysicsMap[id] != nil,
              physicsBodyIDMap[physicsBody] != nil,
              skNodePhysicsBodyMap[physicsBody.node] != nil else {
            assertionFailure("Trying to sync for an id that does not exist.")
            return
        }
        bodyIDPhysicsMap[id]?.updateWith(newPhysicsBody: physicsBody)
    }
}
