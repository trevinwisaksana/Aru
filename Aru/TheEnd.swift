//
//  LoadingScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/21/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit

// MARK: - THE END CLASS
class TheEnd: SKScene {
    
    var theEndNote = SKSpriteNode(imageNamed: "theEndNote")
    
    override func didMoveToView(view: SKView) {
        
        // MARK: - SETUP ENDING SCENE
        setupInstructions(theEndNote, positionX: frame.width / 2, positionY: frame.height / 2, alpha: 1, zPosition: 1000)
        
        // This sets up the background color
        backgroundColor = SKColor.blackColor()
        
        /// This constant give a 4 second delay before the scene changes so that the player can read the ending note for 4 seconds.
        let wait = SKAction.waitForDuration(4)
        
        /// This is an SKAction that setups the transition between the ending scene into the menu scene.
        let changeScene = SKAction.runBlock({
            let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 1)
            let scene = MenuScene(size: view.frame.size)
            scene.scaleMode = GameScaleMode.AllScenes
            self.view!.presentScene(scene, transition: transition)
        })
        self.runAction(SKAction.sequence([wait, changeScene]))
    }
    
    // MARK: - FUNCTIONS
    /// This is used to setup instructions. The parameters in this instruction includes the position, size, alpha, hidden and zPosition.
    func setupInstructions(instruction: SKSpriteNode, positionX: CGFloat, positionY: CGFloat, alpha: CGFloat, zPosition: CGFloat) {
        instruction.zPosition = zPosition
        instruction.size = CGSize(width: instruction.size.width / 3.35, height: instruction.size.height / 3.35)
        instruction.alpha = alpha
        instruction.position = CGPoint(x: positionX, y: positionY)
        instruction.hidden = false
        addChild(instruction)
    }
    
}
