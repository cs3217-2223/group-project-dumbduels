//
//  TankComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class TankComponent: Component {
    var id: ComponentID
    var index: Int
    var rotationDirection: CGFloat = 1
    let fsm: EntityStateMachine<State>

    init(index: Int, fsm: EntityStateMachine<State>) {
        self.id = ComponentID()
        self.index = index
        self.fsm = fsm
    }
}

extension TankComponent {
    enum State {
        case charging0
        case charging1
        case charging2
    }
}
