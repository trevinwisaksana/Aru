//
//  Variables.swift
//  Aru
//
//  Created by Trevin Wisaksana on 7/23/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit

// This helps make sure that the level is only run once
var alreadyRan = false

// Delcaring joystick property
var base: SKSpriteNode!
var stick: SKSpriteNode!
// Declaring stick active property
var stickActive: Bool! = false
var xValue: CGFloat = 0
var yValue: CGFloat = 0

// Declaring character property
var blueCharacter: Character!
var pinkCharacter: Character!

// Declaring the switchButton property
var switchButton: MSButtonNode!
var buttonFunctioning: Bool = true
var jumpButton: MSButtonNode!
var alreadyTapped: Bool = true

// Allows the button to be pressed once every 1 second
var canJump = true

// Array to contain the links of the joints
var links: [SKSpriteNode]!

// Creating the checkpoint object
var target: Checkpoint!

// Create camera
var characterCamera = SKCameraNode()

// Distance between each character
var distanceOfCharacterDifference: CGFloat!

// Separate Button
var separateButton: MSButtonNode!

// Separate button executed
var separationExecuted: Bool = true

// Two characters made contact
var madeContact: Bool = false
