////
////  Checkpoint.swift
////  Aru
////
////  Created by Trevin Wisaksana on 7/18/16.
////  Copyright © 2016 Trevin Wisaksana. All rights reserved.
////
//
//import SpriteKit
//
//class Checkpoint: SKSpriteNode {
//    
//    // Creating the checkpoint object
//    var checkpoint = SKSpriteNode(imageNamed: "checkpoint")
//    
//    // These are the attributes for the checkpoint 
//    checkpoint.physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
//    checkpoint.position = CGPoint(x: 522, y: 185)
//    checkpoint.physicsBody?.affectedByGravity = false
//    checkpoint.zPosition = 10
//    checkpoint.physicsBody?.categoryBitMask = PhysicsCategory.checkpoint
//    checkpoint.physicsBody?.collisionBitMask = PhysicsCategory.None
//    checkpoint.physicsBody?.contactTestBitMask = PhysicsCategory.blueCharacter | PhysicsCategory.pinkCharacter
//    addChild(checkpoint)
//    
//    // You are required to implement this for your subclass to work
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//    }
//    
//    // You are required to implement this for your subclass to work
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
