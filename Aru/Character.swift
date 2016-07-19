//
//  Character.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This document contains attributes of the Pink and Blue characters. This document also contains the part where the chain betweent he Pink and Blue characters are created.

import SpriteKit

class Character: SKSpriteNode {
    
    // Declaring character property
    var blueCharacter = SKSpriteNode(imageNamed: "blueBall")
    var pinkCharacter = SKSpriteNode(imageNamed: "pinkBall")
    
    // Array to contain the links of the joints
    var links: [SKSpriteNode]!
    
    func createCharacter() {
        // This creates the two characters //
        
        // Referencing blueCharacter to connect to the scene //
        blueCharacter.physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        blueCharacter.position = CGPoint(x: 70, y: 125)
        blueCharacter.physicsBody?.mass = 1
        blueCharacter.size = CGSize(width: 23, height: 23)
        blueCharacter.physicsBody?.affectedByGravity = true
        blueCharacter.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueCharacter.physicsBody?.categoryBitMask = PhysicsCategory.BlueCharacter
        blueCharacter.physicsBody?.collisionBitMask = PhysicsCategory.PinkCharacter | PhysicsCategory.Platform | PhysicsCategory.Edge | PhysicsCategory.BlueCharacter
        // This is so that it collides with the platform
        blueCharacter.physicsBody?.contactTestBitMask = PhysicsCategory.Checkpoint
        self.addChild(blueCharacter)
        
        // Referencing pinkCharacter to connect to the scene //
        pinkCharacter.position = CGPoint(x: 50, y: 125)
        pinkCharacter.size = CGSize(width: 23, height: 23)
        // Declaration of physicsBody must be placed on top before setting the rest of the physics roperties //
        pinkCharacter.physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        pinkCharacter.physicsBody!.mass = 1
        pinkCharacter.physicsBody!.affectedByGravity = true
        pinkCharacter.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pinkCharacter.physicsBody!.categoryBitMask = PhysicsCategory.PinkCharacter
        pinkCharacter.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.Platform
        pinkCharacter.physicsBody?.contactTestBitMask = PhysicsCategory.Checkpoint
        self.addChild(pinkCharacter)
    }
    
    // You are required to implement this for your subclass to work
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    // You are required to implement this for your subclass to work
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

