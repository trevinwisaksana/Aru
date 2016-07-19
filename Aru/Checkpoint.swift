//
//  Checkpoint.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This is a class for Checkpoint. Inside here are attributes for the checkpoint node.

import SpriteKit

// This enum contains the name of the file in which it will be called when it looks for the texture
enum CheckpointNode: String {
    case Sprite = "checkpoint"
}

class Checkpoint: SKSpriteNode {
    
    // Creating the checkpoint object
    var checkpoint: CheckpointNode
    
    // These are the attributes for the checkpoint
    init(checkpointSprite: CheckpointNode) {
        self.checkpoint = checkpointSprite
        
        let texture = SKTexture(imageNamed: checkpointSprite.rawValue)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        // Do not need to declare the position here, but in the GameScene instead
        physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        physicsBody?.affectedByGravity = false
        zPosition = 10
        physicsBody?.categoryBitMask = PhysicsCategory.Checkpoint
        physicsBody?.collisionBitMask = PhysicsCategory.None
        physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
    }
    
    // You are required to implement this for your subclass to work
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}