//
//  Level1.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/28/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameOver: GKState {
    
    unowned let scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
        
        
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return true
    }
    
    override func willExitWithNextState(nextState: GKState) {
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
    }
    
    
    
}
