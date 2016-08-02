//
//  LoadingScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/21/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit

class TheEnd: SKScene {
    
    var logo: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
    
        backgroundColor = SKColor.blackColor()
        let wait = SKAction.waitForDuration(5)
        let changeScene = SKAction.runBlock({
            let transition = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
            let scene = MenuScene(fileNamed: "MenuScene")
            scene!.scaleMode = .AspectFill
            self.view!.presentScene(scene!, transition: transition)
        })
        self.runAction(SKAction.sequence([wait, changeScene]))
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}
