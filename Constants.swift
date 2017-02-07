//
//  Constants.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/19/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SpriteKit

// MARK: - PHYSICS CATEGORIES
// These are the physics categories which must be set to allow collisions and contacts between objects
public struct PhysicsCategory {
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
    // This is the trigger that shows the switch button instruction
    static let TriggerSwitchIns: UInt32 = 0b1000000000
}

// MARK: - SCREEN SCALE MODE
public struct GameScaleMode {
    static let AllScenes: SKSceneScaleMode = .ResizeFill
}

// This is a global variable because it will be used at different classes
// MARK: - ARRAY OF LEVELS
public let arrayOfLevels: Array = ["Level0",
                                    "Level1",
                                    "Level2",
                                    "Level3",
                                    "Level4",
                                    "Level5",
                                    "Level6",
                                    "Level7",
                                    "Level8",
                                    "Level9",
                                    "Level10"]