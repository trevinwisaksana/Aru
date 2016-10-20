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
    
    var restartButton = MSButtonNode(imageNamed: "restartButton")
    var background = SKSpriteNode(imageNamed: "tryAgain")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // Button property
        restartButton.position = CGPoint(x: frame.size.width * 0.7, y: frame.size.height / 2)
        restartButton.size = CGSize(width: restartButton.size.width / 4, height: restartButton.size.width / 4)
        restartButton.zPosition = 100
        addChild(restartButton)
        
        if view.frame.size == CGSize(width: 480, height: 320) {
            background.position = CGPoint(x: 280, y: frame.height / 2)
            background.size =  CGSize(width: background.size.width / 3.35, height: background.size.height / 3.35)
            background.zPosition = -1
            addChild(background)
        } else {
            background.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            background.size =  CGSize(width: view.frame.size.width, height: view.frame.size.height)
            background.zPosition = -1
            addChild(background)
        }
        
        // Restart Button
        restartButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            if let scene = GameScene(fileNamed: arrayOfLevels[levelNumber]) {
                scene.scaleMode = GameScaleMode.AllScenes
                self.view!.presentScene(scene, transition: reveal)
            }
               
        }
        
        restartButton.state = .Active
    }
    
    
}