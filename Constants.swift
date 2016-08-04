//
//  Constants.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/19/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SpriteKit

// These are the physics categories which must be set to allow collisions and contacts between objects
struct PhysicsCategory {
    static let None: UInt32             = 0         // 000000
    static let BlueCharacter: UInt32    = 0b1       // 000001
    static let PinkCharacter: UInt32    = 0b10      // 000010
    static let Checkpoint: UInt32       = 0b100     // 000100
    static let Platform: UInt32         = 0b1000    // 001000
    static let Edge: UInt32             = 0b10000   // 010000
    static let Trigger: UInt32          = 0b100000  // 100000
    static let BridgeNode: UInt32       = 0b1000000
    static let FallingPlatform: UInt32  = 0b10000000
    static let TransPlatform: UInt32    = 0b100000000
}

struct GameScaleMode {
    static let AllScenes: SKSceneScaleMode = .AspectFit
}

// GameScaleMode.AllScenes