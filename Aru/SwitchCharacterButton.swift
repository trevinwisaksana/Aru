//
//  Character.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This document contains attributes of the Pink and Blue characters. This document also contains the part where the chain betweent he Pink and Blue characters are created.

import SpriteKit

enum SwitchButton: String {
    case SwitchButtonName = "switchButton"
}

class SwitchCharacterButton: MSButtonNode {
    
    let switchButtonNode: SwitchButton
    
    init(switchButton: SwitchButton) {
        self.switchButtonNode = switchButton
        
        let texture = SKTexture(imageNamed: switchButton.rawValue)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        // Do not need to declare the position here, but in the GameScene instead
        zPosition = 100
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

