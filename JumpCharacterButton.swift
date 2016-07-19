//
//  Character.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This document contains attributes of the Pink and Blue characters. This document also contains the part where the chain betweent he Pink and Blue characters are created.

import SpriteKit

enum JumpButton: String {
    case JumpButtonName = "jumpButton"
}

class JumpCharacterButton: MSButtonNode {
    
    let jumpButtonNode: JumpButton
    
    init(jumpButtons: JumpButton) {
        self.jumpButtonNode = jumpButtons
        
        let texture = SKTexture(imageNamed: jumpButtons.rawValue)

        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        // Do not need to declare the position here, but in the GameScene instead
        zPosition = 100
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(">>>>>>>>>>>>>>><<<<<<<<<<<<<<<")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

