//
//  Character.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/18/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//  This document contains the joystick class

import SpriteKit

enum JoystickProperties: String {
    case Base = "base"
    case Stick = "joystick"
}

class Joystick: SKSpriteNode {
    
    let joystickProperty: JoystickProperties
    
    init(joystick: JoystickProperties) {
        self.joystickProperty = joystick
        
        let texture = SKTexture(imageNamed: joystick.rawValue)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        // Do not need to declare the position here, but in the GameScene instead
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

