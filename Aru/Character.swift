//
//  Character.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This document contains attributes of the Pink and Blue characters. This document also contains the part where the chain betweent he Pink and Blue characters are created.

import SpriteKit

// This enum is used to help determine which color the ball is because without this it won't be able to recognized whether if the ball is blue or pink
enum CharacterColor: String {
    case Pink = "pinkBall"
    case Blue = "blueBall"
}

class Character: SKSpriteNode {
        
    let characterColor: CharacterColor
    
    init(characterColor: CharacterColor) {
        self.characterColor = characterColor
        
        let texture = SKTexture(imageNamed: characterColor.rawValue)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        // Do not need to declare the position here, but in the GameScene instead
        physicsBody = SKPhysicsBody(circleOfRadius: 8)
        physicsBody?.mass = 0.989
        size = CGSize(width: 16, height: 16)
        zPosition = 10
        physicsBody?.friction = 0.5
        physicsBody?.affectedByGravity = true
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        if characterColor.rawValue == "pinkBall" {
            physicsBody?.categoryBitMask = PhysicsCategory.PinkCharacter
            physicsBody?.contactTestBitMask = PhysicsCategory.Checkpoint | PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger
        } else {
            physicsBody?.categoryBitMask = PhysicsCategory.BlueCharacter
            physicsBody?.contactTestBitMask = PhysicsCategory.Checkpoint | PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger
        }
        physicsBody?.collisionBitMask = PhysicsCategory.PinkCharacter | PhysicsCategory.Platform | PhysicsCategory.Edge | PhysicsCategory.BlueCharacter
        // This is so that it collides with the platform
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

