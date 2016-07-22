//
//  LoadingScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/21/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit

class LoadingScene: SKScene {
    
    var logo: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.whiteColor()
        
        let logoPresent = SKAction.runBlock({
            let logoAppear = SKAction.fadeInWithDuration(5)
            self.logo = SKSpriteNode(imageNamed: "logo")
            self.logo.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
            self.logo.size = CGSize(width: self.logo.size.width / 6, height: self.logo.size.height / 6)
            self.addChild(self.logo)
        })
        let logoDisappear = SKAction.fadeOutWithDuration(1)
        let wait = SKAction.waitForDuration(2)
        let changeScene = SKAction.runBlock({
            let transition = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
            let scene = MenuScene(size: view.frame.size)
            scene.scaleMode = .AspectFill
            self.view!.presentScene(scene, transition: transition)
        })
        self.runAction(SKAction.sequence([logoPresent, wait, logoDisappear, changeScene]))
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}
