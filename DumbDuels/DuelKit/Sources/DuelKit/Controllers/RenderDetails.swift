//
//  RenderDetails.swift
//  DuelKit
//
//  Created by Esmanda Wong on 17/3/23.
//

import CoreGraphics

struct RenderDetails {
    let spriteName: String
    let alpha: CGFloat
    let zPosition: CGFloat
    let centerPosition: CGPoint
    let width: CGFloat
    let height: CGFloat
    let rotation: CGFloat
    let facing: FaceDirection

    init(spriteName: String,
         alpha: CGFloat,
         zPosition: CGFloat,
         centerPosition: CGPoint,
         width: CGFloat,
         height: CGFloat,
         rotation: CGFloat = 0,
         facing: FaceDirection = .right) {
        self.spriteName = spriteName
        self.alpha = alpha
        self.zPosition = zPosition
        self.centerPosition = centerPosition
        self.width = width
        self.height = height
        self.rotation = rotation
        self.facing = facing
    }
}
