//
//  LevelCompleteScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/6/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteScene: SKScene {
    
    var restartButton = MSButtonNode(color: SKColor.blueColor(), size: CGSize(width: 100, height: 50))
    
    override init(size: CGSize) {
        
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        // Button property
        restartButton.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        restartButton.zPosition = 100
        addChild(restartButton)
        
        // Restart Button
        restartButton.selectedHandler = {
            print("RESTART BUTTON TAPPED")
            let reveal = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.5)
            let scene = GameScene(fileNamed:"GameScene")
            scene!.scaleMode = .AspectFill
            self.view?.presentScene(scene!, transition: reveal)
        }
        
        restartButton.state = .Active
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// The level is complete and it reveals the LevelCompleteScene 
    // After that, we want it to transfer to a new scene but with the controls still there
    