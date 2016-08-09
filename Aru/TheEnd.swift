//
//  LoadingScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/21/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit

class TheEnd: SKScene {
    
    var theEndNote = SKSpriteNode(imageNamed: "theEndNote")
    
    override func didMoveToView(view: SKView) {
        
        setupInstructions(theEndNote, positionX: frame.width / 2, positionY: frame.height / 2, alpha: 1, zPosition: 1000)
        
        backgroundColor = SKColor.blackColor()
        let wait = SKAction.waitForDuration(4)
        let changeScene = SKAction.runBlock({
            let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 1)
            let scene = MenuScene(size: view.frame.size)
            scene.scaleMode = GameScaleMode.AllScenes
            self.view!.presentScene(scene, transition: transition)
        })
        self.runAction(SKAction.sequence([wait, changeScene]))
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    /// Used to setup instructions so that we don't have to repeat code.
    func setupInstructions(instruction: SKSpriteNode, positionX: CGFloat, positionY: CGFloat, alpha: CGFloat, zPosition: CGFloat) {
        instruction.zPosition = zPosition
        instruction.size = CGSize(width: instruction.size.width / 3.35, height: instruction.size.height / 3.35)
        instruction.alpha = alpha
        instruction.position = CGPoint(x: positionX, y: positionY)
        instruction.hidden = false
        addChild(instruction)
    }
    
}
