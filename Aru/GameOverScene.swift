//
//  LevelCompleteScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/6/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var restartButton = MSButtonNode(color: SKColor.blueColor(), size: CGSize(width: 100, height: 50))
    var background = SKSpriteNode(imageNamed: "menuBackground")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // Button property
        restartButton.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        restartButton.zPosition = 100
        addChild(restartButton)
        
        background.position = CGPoint(x: frame.width / 2, y: frame.height * 0.7)
        background.size =  CGSize(width: view.frame.size.width * 2, height: view.frame.size.height * 2)
        background.zPosition = -1
        addChild(background)
        
        // Restart Button
        restartButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            if let scene = GameScene(fileNamed: arrayOfLevels[levelChanger]) {
                scene.scaleMode = GameScaleMode.AllScenes
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load IntroLvl2")
            }
        }
        restartButton.state = .Active
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}