//
//  EntityID.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

struct EntityID {
    typealias ID = String
    
    let id: ID
    
    init(_ id: ID = UUID().uuidString) {
        self.id = id
    }
}

extension EntityID: Equatable {}
extension EntityID: Hashable {}
