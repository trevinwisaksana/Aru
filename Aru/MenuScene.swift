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
    
    var playButton: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        playButton = MSButtonNode(imageNamed: "playButton")
        playButton.zPosition = 10
        playButton.size = CGSize(width: playButton.size.width / 3, height: playButton.size.height / 3)
        playButton.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height / 2)
        addChild(playButton)
        playButtonActivate()
        playButton.state = .Active
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    func playButtonActivate() {
        playButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
            let scene = GameScene(fileNamed: "IntroLvl1")
            scene?.scaleMode = .AspectFill
            self.view!.presentScene(scene!, transition: reveal)
            self.playButton.state = .Active
        }
    }
}
