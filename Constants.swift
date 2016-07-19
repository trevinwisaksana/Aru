//
//  Constants.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/19/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import UIKit

// These are the physics categories which must be set to allow collisions and contacts between objects
struct PhysicsCategory {
    static let None: UInt32             = 0         // 00000
    static let BlueCharacter: UInt32    = 0b1       // 00001
    static let PinkCharacter: UInt32    = 0b10      // 00010
    static let Checkpoint: UInt32       = 0b100     // 00100
    static let Platform: UInt32         = 0b1000    // 01000
    static let Edge: UInt32             = 0b10000   // 10000
}
