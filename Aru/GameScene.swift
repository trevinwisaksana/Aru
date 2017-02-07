//
//  GameScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//  In GameScene, only place the Gaming properties and attributes. Place different levels in different scenes or different states as a state machine is set up.


import SpriteKit
import AVFoundation


// MARK: - GAMESCENE CLASS
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - CHARACTER OBJECTS
    
    
    // MARK: -- Blue character
    var blueCharacter: Character!
    
    // MARK: -- Pink character
    var pinkCharacter: Character!
    
    
    // MARK: - CONTROLLER OBJECTS
    
    
    // MARK: -- Button to move left object
    var leftButton: MSButtonNode!
    
    // MARK: -- Button to move right object
    var rightButton: MSButtonNode!
    
    // MARK: -- Jump button object
    var jumpButton: MSButtonNode!
    
    // MARK: -- Healthbar object
    var healthbar: MSButtonNode!
    
    // MARK: - PAUSE BUTTON OBJECTS
    
    
    // MARK: -- Restart button object
    var restartButton: MSButtonNode!
    
    // MARK: -- Continue button object
    var continueButton: MSButtonNode!
    
    // MARK: -- Home button object
    var homeButton: MSButtonNode!
    
    // MARK: -- Sound on/off button object
    var soundOnOff: MSButtonNode!
    
    // MARK: - AUDIO OBJECTS
    
    
    // MARK: - CHECKPOINT OBJECTS
    
    
    // MARK: - CALCULATION OBJECTS
    
    
    // MARK: - SETTINGS
    
    
    
    
    // MARK: - DID MOVE TO VIEW METHOD
    override func didMoveToView(view: SKView) {
        
        /// This is used so that in each level, only some code will run instead of all of them. This saves memory.
        switch levelNumber {
        case 0:
            // This is for Level 0
            break
        default:
            break
        }
        
        // MARK: -- Controller attributes
        
    
    
    }
    
    // MARK: - TOUCHES BEGAN METHOD
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    // MARK: - UPDATE METHOD
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}
