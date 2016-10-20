//
//  Checkpoint.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This is a class for Checkpoint. Inside here are attributes for the checkpoint node.

import SpriteKit

class Checkpoint: SKSpriteNode {
    
    func setup() {
        // NOTE: - Do not declare the position of the checkpoint here, but in the Scene Editor instead
        physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = false
        zPosition = 10
        physicsBody?.categoryBitMask = PhysicsCategory.Checkpoint
        physicsBody?.collisionBitMask = PhysicsCategory.None
        physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
    }
    
    // You are required to implement this for your subclass to work
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}