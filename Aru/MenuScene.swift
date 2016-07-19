//
//  MenuScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/28/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    var startButton: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        startButton = MSButtonNode(color: SKColor.brownColor(), size: CGSize(width: 100, height: 50))
        startButton.zPosition = 10
        startButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(startButton)
        startButtonActivate()
        startButton.state = .Active
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    func startButtonActivate() {
        startButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
            let scene = GameScene(fileNamed: "IntroLvl1")
            scene?.scaleMode = .AspectFill
            self.view!.presentScene(scene!, transition: reveal)
            self.startButton.state = .Active
        }
    }
}
