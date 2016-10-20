//
//  Character.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This document contains attributes of the Pink and Blue characters. This document also contains the part where the chain betweent he Pink and Blue characters are created.

import SpriteKit

/// This is used to help determine which color the ball is because without this it won't be able to recognized whether if the ball is blue or pink
enum CharacterColor: String {
    case Pink = "pinkCharacter"
    case Blue = "blueCharacter"
}

class Character: SKSpriteNode {
        
    let characterColor: CharacterColor
    
    init(characterColor: CharacterColor) {
        self.characterColor = characterColor
        
        /// This is use to determine the texture of both of the characters
        let texture = SKTexture(imageNamed: characterColor.rawValue)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        // Do not need to declare the position here, but in the GameScene instead because they vary in each level.
        physicsBody = SKPhysicsBody(circleOfRadius: 8)
        physicsBody?.mass = 0.989
        size = CGSize(width: 16, height: 16)
        zPosition = 10
        physicsBody?.friction = 1
        physicsBody?.affectedByGravity = true
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        if characterColor == .Pink {
            // This is the Pink character
            colorBlendFactor = 1
            color = UIColor(red: 230/255, green: 126/255, blue: 208/255, alpha: 1)
            physicsBody?.categoryBitMask = PhysicsCategory.PinkCharacter
            physicsBody?.contactTestBitMask = PhysicsCategory.Checkpoint | PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger
            physicsBody?.collisionBitMask = PhysicsCategory.PinkCharacter | PhysicsCategory.Platform | PhysicsCategory.Edge
        } else {
            // This is the Blue Character
            colorBlendFactor = 1
            color = UIColor(red: 48/255, green: 190/255, blue: 249/255, alpha: 1)
            physicsBody?.categoryBitMask = PhysicsCategory.BlueCharacter
            physicsBody?.contactTestBitMask = PhysicsCategory.Checkpoint | PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger
            physicsBody?.collisionBitMask = PhysicsCategory.PinkCharacter | PhysicsCategory.Platform | PhysicsCategory.Edge
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

