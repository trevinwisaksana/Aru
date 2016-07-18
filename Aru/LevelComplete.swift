//
//  Level1.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/28/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import GameplayKit
import SpriteKit

class LevelComplete: GKState {
    
    unowned let scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
        // let missionAccomplished = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.2)
        let showButtonsAndScore = SKAction.runBlock({
            // Show the score and the
            print("We are at the level complete state")
        })
        // scene.view?.presentScene(/*gameOverScene*/, transition: missionAccomplished)
        let sequence = SKAction.sequence([showButtonsAndScore])
        scene.runAction(sequence)
        
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func willExitWithNextState(nextState: GKState) {
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
    }
    
    
    
}
