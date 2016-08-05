//
//  GameScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//  In GameScene, only place the Gaming properties and attributes. Place different levels in different scenes or different states as a state machine is set up.


import SpriteKit

// The arrayOfLevels is used so that we can call the index number of the level string when changing levels.
///////////////////////////////////////////////////////
// MARK: - Array of Levels
let arrayOfLevels: Array = ["IntroLvl1", // 0
                            "IntroLvl2", // 1
                            "IntroLvl3", // 2
                            "Level1",    // 3
                            "Level2",    // 4
                            "Level3",    // 5
                            "Level4",    // 6
                            "Level5",    // 7
                            "Level6",    // 8
                            "Level7"]    // 9


//////////////////////////////////////////////////////

var completedLevel1: Bool = false
var completedLevel2: Bool = false
var completedLevel3: Bool = false
var completedLevel4: Bool = false
var completedLevel5: Bool = false
var completedLevel6: Bool = false
var completedLevel7: Bool = false

// MARK: - GameScene Class

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
    var connectIndicatorBlue: SKSpriteNode!
    var connectIndicatorPink: SKSpriteNode!
    
    // Declaring the switchButton property
    var switchButton: MSButtonNode!
    var buttonFunctioning: Bool = true
    var jumpButton: MSButtonNode!
    var alreadyTapped: Bool = true
    
    // MARK: - Control Button Properties
    // Declaring pauseButton object
    var pauseButton: MSButtonNode!
    var continueButton: MSButtonNode!
    
    // Allows the button to be pressed once every 1 second
    var canJump = true
    
    // Array to contain the links of the joints
    var links: [SKSpriteNode]!
    var pinLinkCharacterFront: SKPhysicsJointPin!
    var pinLinkCharacterBack: SKPhysicsJointPin!
    var pinLink: SKPhysicsJointPin!
    
    // Creating the checkpoint object
    var target: Checkpoint!
    
    // X Distance between each character
    var distanceOfCharacterDifferenceX: CGFloat!
    
    // Y Distance between each character
    var distanceOfCharacterDifferenceY: CGFloat!
    
    // Separate Button
    var separateButton: MSButtonNode!
    
    // Separate button executed
    var separationExecuted: Bool = true
    
    // Allows switchButton to be active 
    var twoBodiesMadeContact: Bool = false
    
    // Two characters made contact
    var madeContact: Bool = false
    
    // Creating the seesaw 
    var seesaw: SKSpriteNode?
    
    // Creating the bridge
    var bridge: SKSpriteNode?
    var pivot: SKSpriteNode?
    var bridgePin: SKPhysicsJointPin!
    
    // Create camera
    var characterCamera = SKCameraNode()
    
    // Create character indicator 
    var indicator: SKSpriteNode!
    
    // MARK: - Instruction Objects
    // Instructions
    var moveInstruction: SKSpriteNode?
    var tapToJump: SKSpriteNode?
    var tapInstructions: Int = 0
    var baseInstruction = SKSpriteNode(imageNamed: "baseInstruction")
    var stickInstruction = SKSpriteNode(imageNamed: "stickInstruction")
    var handInstruction = SKSpriteNode(imageNamed: "touchingHand")
    var jumpingHand = SKSpriteNode(imageNamed: "jumpingHand")
    var switchInstruction = SKSpriteNode(imageNamed: "switchInstruction")
    var forwardAndJumpIns = SKSpriteNode(imageNamed: "forwardAndJumpIns")
    var workTogetherInstruction = SKSpriteNode(imageNamed: "workTogetherInstruction")
    var alreadyTriggered: Bool = false
    
    // Healthbar objects
    var healthBar = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 250, height: 20))
    var currentHealth: CGFloat = 100
    var maxHealth: CGFloat = 100
    var healthShouldReduce: Bool = false
    
    // Creating trigger object
    var trigger: SKSpriteNode?
    var triggerLvl0: SKSpriteNode?
    var triggerSwitchLvl0: SKSpriteNode?
    
    // Create a blockadge object that will be triggered by the trigger
    var blockade: SKSpriteNode?
    
    // Creating moving platform
    var movingPlatform: SKSpriteNode!
    var fallingPlatform: SKSpriteNode?
    var fallingPlatformLvl0: SKSpriteNode?
    var platformFall: Bool = false
    var platformFallLvl0: Bool = false
    
    // Translating Platform Objects 
    var platformOne: SKSpriteNode?
    var platformTwo: SKSpriteNode?
    var platformThree: SKSpriteNode?
    var platformFour: SKSpriteNode?
    var platformTranslate: Bool = false
    
    // Create a blooshot effect 
    var bloodshot: SKSpriteNode!
    var bloodshotShouldRun: Bool = false {
        didSet {
            if bloodshotShouldRun == true {
                // This starts the effect
                bloodshotEffect()
                // print("***************** bloodshotShouldRun TRUE!")
            } else {
                // This removes the effect
                removeBloodshotEffect()
                // print("+++++++++++++++++ bloodshotShouldRun FALSE")
            }
        }
    }
    
    // MARK: - Menu Objects
    var pauseMenu: SKSpriteNode!
    var homeButton: MSButtonNode!
    
    // MARK: - didMoveToView
    
    override func didMoveToView(view: SKView) {
        
        // Sets the physics world so that it can detect contact
        self.physicsWorld.contactDelegate = self
        
        ////////////////////////////
        /// Character attributes ///
        ////////////////////////////
        
        // From the Character class, the characters gets its position set and is added to the scene
        blueCharacter = Character(characterColor: .Blue)
        pinkCharacter = Character(characterColor: .Pink)
        //
        connectIndicatorBlue = SKSpriteNode(imageNamed: "connectIndicatorTwo")
        connectIndicatorBlue.zPosition = 9
        connectIndicatorBlue.alpha = 0
        connectIndicatorBlue.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        connectIndicatorBlue.size = CGSize(width: 20, height: 20)
        addChild(connectIndicatorBlue)
        //
        connectIndicatorPink = SKSpriteNode(imageNamed: "connectIndicatorTwo")
        connectIndicatorPink.zPosition = 9
        connectIndicatorPink.alpha = 0
        connectIndicatorPink.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        connectIndicatorPink.size = CGSize(width: 20, height: 20)
        addChild(connectIndicatorPink)
        
        addChild(blueCharacter)
        addChild(pinkCharacter)
        
        ////////////////////////
        /// Creating bridges ///
        ////////////////////////
        // Creating a bridge for Level 2 and 5
        if levelChanger == 4 || levelChanger == 7 {
            pivot = childNodeWithName("pivot") as? SKSpriteNode
            bridge = childNodeWithName("bridge") as? SKSpriteNode

            bridgePin = SKPhysicsJointPin.jointWithBodyA(bridge!.physicsBody!,
                                                         bodyB: pivot!.physicsBody!,
                                                         anchor: pivot!.position)
            self.physicsWorld.addJoint(bridgePin)
        }
        
        // Creating fallingPlatform
        fallingPlatform = childNodeWithName("//fallingPlatform") as? SKSpriteNode
        fallingPlatform?.physicsBody?.categoryBitMask = PhysicsCategory.FallingPlatform | PhysicsCategory.BlueCharacter
        fallingPlatform?.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        fallingPlatform?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        
        // Creating platformTranslate 
        platformOne?.physicsBody?.categoryBitMask = PhysicsCategory.TransPlatform | PhysicsCategory.BlueCharacter
        platformOne?.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        platformOne?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        //
        platformTwo?.physicsBody?.categoryBitMask = PhysicsCategory.TransPlatform | PhysicsCategory.BlueCharacter
        platformTwo?.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        platformTwo?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        // 
        platformThree?.physicsBody?.categoryBitMask = PhysicsCategory.TransPlatform | PhysicsCategory.BlueCharacter
        platformThree?.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        platformThree?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        // 
        platformFour?.physicsBody?.categoryBitMask = PhysicsCategory.TransPlatform | PhysicsCategory.BlueCharacter
        platformFour?.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        platformFour?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        
        ///////////////////////////
        /// Creating Checkpoint ///
        ///////////////////////////
        
        // From the Checkpoint class, the checkpoint gets its position set and is added to the scene
        target = childNodeWithName("//checkpoint") as! Checkpoint
        target.setup()
        
        //////////////////////////
        /// Creating Bloodshot ///
        //////////////////////////
        
        // Bloodshot
        bloodshot = childNodeWithName("//bloodshot") as! SKSpriteNode
        bloodshot.hidden = true
        bloodshot.zPosition = 95
        
        /////////////////////////////////////
        /// Creating Trigger and Blocakde ///
        /////////////////////////////////////
        
        // Creating Trigger that will cause the blockade to drop
        trigger = childNodeWithName("//trigger") as? SKSpriteNode
        trigger?.physicsBody = SKPhysicsBody(rectangleOfSize: (trigger?.size)!)
        trigger?.physicsBody?.categoryBitMask = PhysicsCategory.Trigger
        trigger?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        trigger?.physicsBody?.collisionBitMask = PhysicsCategory.None
        trigger?.physicsBody?.affectedByGravity = false
        
        // Another trigger at Level 0
        triggerLvl0 = childNodeWithName("//triggerLvl0") as? SKSpriteNode
        triggerLvl0?.physicsBody = SKPhysicsBody(rectangleOfSize: (triggerLvl0?.size)!)
        triggerLvl0?.physicsBody?.categoryBitMask = PhysicsCategory.Trigger
        triggerLvl0?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        triggerLvl0?.physicsBody?.collisionBitMask = PhysicsCategory.None
        triggerLvl0?.physicsBody?.affectedByGravity = false
        
        // Another trigger at Level 0. This trigger shows the switch button instruciton
        triggerSwitchLvl0 = childNodeWithName("//triggerSwitchLvl0") as? SKSpriteNode
        triggerSwitchLvl0?.physicsBody = SKPhysicsBody(rectangleOfSize: (triggerLvl0?.size)!)
        triggerSwitchLvl0?.physicsBody?.categoryBitMask = PhysicsCategory.TriggerSwitchIns
        triggerSwitchLvl0?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        triggerSwitchLvl0?.physicsBody?.collisionBitMask = PhysicsCategory.None
        triggerSwitchLvl0?.physicsBody?.affectedByGravity = false
        
        // Blockade drops when the character makes contact with the trigger
        blockade = childNodeWithName("//blockade") as? SKSpriteNode
        blockade?.physicsBody?.affectedByGravity = false
        blockade?.physicsBody?.allowsRotation = false
        
        fallingPlatformLvl0 = childNodeWithName("//fallingPlatformLvl2") as? SKSpriteNode
        fallingPlatformLvl0?.physicsBody?.dynamic = false
        fallingPlatformLvl0?.physicsBody?.affectedByGravity = false
        fallingPlatformLvl0?.physicsBody?.allowsRotation = false
        
        
        ///////////////////////////
        /// Creating Health Bar ///
        ///////////////////////////
        healthBar.position = CGPoint(x: -270, y: 140)
        healthBar.zPosition = 4
        healthBar.anchorPoint.x = 0
        //print(healthBar.position)
        
        /////////////////////////////
        /// Creating Pause Button ///
        /////////////////////////////
        pauseButton = MSButtonNode(imageNamed: "pauseButton")
        pauseButton.size = CGSize(width: pauseButton.size.width / 3, height: pauseButton.size.height / 3)
        pauseButton.position = CGPoint(x: 250, y: 130)
        pauseButton.zPosition = 1000
        pauseButton.state = .Active
        characterCamera.addChild(pauseButton)
        setupPauseButton()
        
        //////////////////////////
        /// Creating pauseMenu ///
        //////////////////////////
        pauseMenu = SKSpriteNode(imageNamed: "pauseMenu")
        pauseMenu.position = CGPoint(x: 203, y: 80)
        pauseMenu.size = CGSize(width: self.pauseMenu.size.width / 2.5, height: self.pauseMenu.size.height / 2.5)
        pauseMenu.zPosition = 1000
        pauseMenu.alpha = 0
        pauseMenu.hidden = true
        characterCamera.addChild(pauseMenu)
        
        ////////////////////////////
        /// Creating Play Button ///
        ////////////////////////////
        continueButton = MSButtonNode(imageNamed: "continueToPlayButton")
        continueButton.size = CGSize(width: continueButton.size.width / 2, height: continueButton.size.height / 2)
        continueButton.position = CGPoint(x: -20, y: -10)
        continueButton.zPosition = 15
        continueButton.state = .Active
        continueButton.hidden = true
        pauseMenu.addChild(continueButton)
        setupPlayButton()
        
        ////////////////////////////
        /// Creating Home Button ///
        ////////////////////////////
        homeButton = MSButtonNode(imageNamed: "homeButton")
        homeButton.position = CGPoint(x: -60, y: 50)
        homeButton.size = CGSize(width: homeButton.size.width / 2, height: homeButton.size.height / 2)
        homeButton.zPosition = 15
        homeButton.state = .Active
        homeButton.hidden = true
        pauseMenu.addChild(homeButton)
        setupHomeButton()
        
        ///////////////////////////
        /// Creating indicator  ///
        ///////////////////////////
        indicator = SKSpriteNode(imageNamed: "indicator")
        indicator.size = CGSize(width: self.size.width / 50, height: self.size.height / 50)
        indicator.zPosition = 100
        indicator.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(indicator)
        
        ///////////////////////////
        /// Joystick properties ///
        ///////////////////////////
        // Creates the joystick
        base = SKSpriteNode(imageNamed: "base")
        base.size = CGSize(width: 100, height: 100)
        base.zPosition = 10
        base.position.x = -200
        base.position.y = -90
        base.alpha = 1
        
        stick = SKSpriteNode(imageNamed: "stick")
        stick.size = CGSize(width: 80, height: 80)
        base.addChild(stick)
        
        ////////////////////////////
        /// Creating instructions //
        ////////////////////////////
        
        // MARK: - Setup the instructions
        moveInstruction = SKSpriteNode(imageNamed: "moveInstruction")
        moveInstruction?.zPosition = 100
        moveInstruction?.size = CGSize(width: moveInstruction!.size.width / 3.2, height: moveInstruction!.size.height / 3.2)
        moveInstruction?.alpha = 0
        moveInstruction?.position = CGPoint(x: -150, y: -10)
        characterCamera.addChild(moveInstruction!)
        // moveInstruction?.hidden = false
        
        forwardAndJumpIns = SKSpriteNode(imageNamed: "tapToJump")
        forwardAndJumpIns.zPosition = 100
        forwardAndJumpIns.size = CGSize(width: forwardAndJumpIns.size.width / 3.2, height: forwardAndJumpIns.size.height / 3.2)
        forwardAndJumpIns.alpha = 0
        forwardAndJumpIns.position = CGPoint(x: 0, y: -20)
        characterCamera.addChild(forwardAndJumpIns)
        // moveInstruction?.hidden = false
        
        baseInstruction.zPosition = 101
        baseInstruction.size = CGSize(width: 50, height: 50)
        baseInstruction.alpha = 1
        baseInstruction.hidden = true
        baseInstruction.position = CGPoint(x: -100, y: -100)
        characterCamera.addChild(baseInstruction)
        
        stickInstruction.zPosition = 102
        stickInstruction.size = CGSize(width: 40, height: 40)
        stickInstruction.alpha = 1
        stickInstruction.position = CGPoint(x: 0, y: 0)
        baseInstruction.addChild(stickInstruction)
        
        tapToJump = SKSpriteNode(imageNamed: "tapToJump")
        tapToJump?.zPosition = 100
        tapToJump?.size = CGSize(width: tapToJump!.size.width / 3.2, height: tapToJump!.size.height / 3.2)
        tapToJump?.alpha = 1
        tapToJump?.hidden = true
        tapToJump?.position = CGPoint(x: 150, y: 0)
        characterCamera.addChild(tapToJump!)
        
        switchInstruction.zPosition = 100
        switchInstruction.size = CGSize(width: tapToJump!.size.width / 1, height: tapToJump!.size.height / 1)
        switchInstruction.alpha = 1
        switchInstruction.hidden = true
        switchInstruction.position = CGPoint(x: 90, y: -100)
        characterCamera.addChild(switchInstruction)
        
        handInstruction.zPosition = 102
        handInstruction.size = CGSize(width: handInstruction.size.width / 9, height: handInstruction.size.height / 9)
        handInstruction.alpha = 0
        handInstruction.position = CGPoint(x: -80, y: -150)
        characterCamera.addChild(handInstruction)
        
        jumpingHand.zPosition = 102
        jumpingHand.size = CGSize(width: jumpingHand.size.width / 6, height: jumpingHand.size.height / 6)
        jumpingHand.alpha = 0
        jumpingHand.position = CGPoint(x: 140, y: -90)
        characterCamera.addChild(jumpingHand)

        
        ////////////////////////////////////////////////////////////
        /// Creating different positions for spawning the players //
        ////////////////////////////////////////////////////////////
        // This is a list of the different positions of the characters
        switch levelChanger {
        case 0:
            // This is introLevel1
            blueCharacter.position = CGPoint(x: 110, y: 125)
            pinkCharacter.position = CGPoint(x: 100, y: 125)
            
            // This is the animation for the tutorials
            let handFadeIn = SKAction.fadeInWithDuration(0.5)
            let handMove = SKAction.moveToX(-25, duration: 1)
            let handStart = SKAction.moveToX(-80, duration: 0.7)
            let hideHand = SKAction.runBlock({
                self.handInstruction.hidden = true
            })
            let showHand = SKAction.runBlock({
                self.handInstruction.hidden = false
            })
            let sequenceHand = SKAction.sequence([handFadeIn, handMove, hideHand, handStart, showHand])
            handInstruction.runAction(SKAction.repeatActionForever(sequenceHand))
            
            // Tutorial objects and properties
            let fadeIn = SKAction.fadeInWithDuration(0.5)
            let sequence = SKAction.sequence([fadeIn])
            moveInstruction?.runAction(sequence)
            
            // Tutorial objects and properties
            forwardAndJumpIns.hidden = false
            jumpingHand.hidden = false
            let fadeInJump = SKAction.fadeInWithDuration(0.5)
            let sequenceJump = SKAction.sequence([fadeInJump])
            forwardAndJumpIns.runAction(sequenceJump)
            
            // Jumping Hand Animation
            jumpingHand.alpha = 1
            let jumpHandScaleBig = SKAction.scaleTo(1.5, duration: 1)
            let jumpHandScaleSmall = SKAction.scaleTo(1, duration: 1)
            let jumpHandSequence = SKAction.sequence([jumpHandScaleBig, jumpHandScaleSmall])
            jumpingHand.runAction(SKAction.repeatActionForever(jumpHandSequence))
           
            let wait = SKAction.waitForDuration(0.45)
            let show = SKAction.runBlock({
                self.baseInstruction.hidden = false
            })
            let waitForShow = SKAction.waitForDuration(1.05)
            let baseHide = SKAction.runBlock({
                self.baseInstruction.hidden = true
            })
            let waitAgain = SKAction.waitForDuration(0.7)
            let baseSeq = SKAction.sequence([wait, show, waitForShow, baseHide, waitAgain])
            baseInstruction.runAction(SKAction.repeatActionForever(baseSeq))
            
            let stickWait = SKAction.waitForDuration(0.5)
            let start = SKAction.moveToX(0, duration: 0.7)
            let move = SKAction.moveToX(60, duration: 1)
            let hide = SKAction.runBlock({
                self.stickInstruction.hidden = true
            })
            let hideFalse = SKAction.runBlock({
                self.stickInstruction.hidden = false
            })
            stickInstruction.runAction(SKAction.repeatActionForever(SKAction.sequence([stickWait, move, hide, start, hideFalse])))
            
        case 1:
            // This is introLevel2
            blueCharacter.position = CGPoint(x: 160, y: 125)
            pinkCharacter.position = CGPoint(x: 145, y: 125)
            
            workTogetherInstruction.zPosition = 100
            workTogetherInstruction.size = CGSize(width: workTogetherInstruction.size.width / 3, height: workTogetherInstruction.size.height / 3)
            workTogetherInstruction.alpha = 1
            workTogetherInstruction.hidden = false
            workTogetherInstruction.position = CGPoint(x: -120, y: -10)
            characterCamera.addChild(workTogetherInstruction)
            
            let showText = SKAction.fadeInWithDuration(0.5)
            let waitToShow = SKAction.waitForDuration(2)
            let doNotShowText = SKAction.fadeOutWithDuration(0.5)
            workTogetherInstruction.runAction(SKAction.sequence([showText, waitToShow, doNotShowText]))
            print("LEVEL CHANGER == 1")
        
        case 2:
            // This is introLevel3
            blueCharacter.position = CGPoint(x: 180, y: 175)
            pinkCharacter.position = CGPoint(x: 160, y: 175)
        case 3:
            // This is Level 1
            blueCharacter.position = CGPoint(x: 520, y: 260)
            pinkCharacter.position = CGPoint(x: 50, y: 260)
            blueCharacter.physicsBody?.linearDamping = 1
            pinkCharacter.physicsBody?.linearDamping = 1
        case 4:
            // This is Level 2
            blueCharacter.position = CGPoint(x: 70, y: 175)
            pinkCharacter.position = CGPoint(x: 60, y: 175)
        case 5:
            // This is Level 3
            blueCharacter.position = CGPoint(x: 50, y: 100)
            pinkCharacter.position = CGPoint(x: 40, y: 100)
        case 6:
            // This is Level 4
            blueCharacter.position = CGPoint(x: 280, y: 274)
            pinkCharacter.position = CGPoint(x: 265, y: 274)
        case 7:
            // This is Level 5
            blueCharacter.position = CGPoint(x: 60, y: 260)
            pinkCharacter.position = CGPoint(x: 50, y: 260)
            movingPlatform = childNodeWithName("//movingPlatform") as! SKSpriteNode
            let moveLeft = SKAction.moveToX(100, duration: 4)
            let moveRight = SKAction.moveToX(192, duration: 4)
            self.movingPlatform.runAction(SKAction.repeatActionForever(SKAction.sequence([moveLeft, moveRight])))
        case 8:
            // This is Level 6
            blueCharacter.position = CGPoint(x: 60, y: 300)
            pinkCharacter.position = CGPoint(x: 50, y: 300)
        case 9:
            // This is Level 7
            blueCharacter.position = CGPoint(x: 60, y: 150)
            pinkCharacter.position = CGPoint(x: 50, y: 150)
            platformOne = childNodeWithName("1") as? SKSpriteNode
            platformTwo = childNodeWithName("2") as? SKSpriteNode
            platformThree = childNodeWithName("3") as? SKSpriteNode
            platformFour = childNodeWithName("4") as? SKSpriteNode
        default:
            break
            
        }
        
        ////////////////////////////////////
        /// These are buttons properties ///
        ////////////////////////////////////
        
        // Creates the jump and switch button
        switchButton = MSButtonNode(imageNamed: "blueSwitchButton")
        switchButton.size = CGSize(width: switchButton.size.width / 7, height: switchButton.size.height / 7)
        switchButton.zPosition = 101
        switchButton.position.x = 220
        switchButton.position.y = -100
        
        jumpButton = MSButtonNode(color: SKColor.clearColor(), size: CGSize(width: self.frame.width / 2, height: self.frame.height))
        jumpButton.position.x = 142
        jumpButton.position.y = 0
        jumpButton.zPosition = 98
        
        separateButton = MSButtonNode(imageNamed: "separateBlueButton")
        separateButton.size = CGSize(width: separateButton.size.width / 16, height: separateButton.size.height / 16)
        separateButton.zPosition = 101
        separateButton.position = CGPoint(x: 120, y: -110)
        
        // Button States
        if levelChanger == 0 {
            separateButton.state = .Inactive
        } else {
            separateButton.state = .Active
        }
        
        switchButton.state = .Active
        jumpButton.state = .Active
        
        // Adding the camera as the button's parent so that it follows its position
        characterCamera.addChild(switchButton)
        characterCamera.addChild(jumpButton)
        characterCamera.addChild(base)
        characterCamera.addChild(separateButton)
        characterCamera.addChild(healthBar)
        // characterCamera.addChild(indicator)
        
        /////////////////////////
        /// Camera attributes ///
        /////////////////////////
        
        // Assuring that the target of the camera is the character's position
        addChild(characterCamera)
        self.camera = characterCamera
        characterCamera.xScale = 0.32
        characterCamera.yScale = 0.32
        
        /////////////////////////
        /// Calling functions ///
        /////////////////////////
    
        activateJumpButton()
        activateSwitchButton()
        createChain(characterBack: pinkCharacter, characterFront: blueCharacter)
        activateSeparateButton()
    
        // Creating a physical boundary to the edge of the scene
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        physicsBody?.categoryBitMask = PhysicsCategory.Platform
        physicsBody?.collisionBitMask = 1
        
        if levelChanger == 0 || levelChanger == 1 {
            self.separateButton.state = .Inactive
        }
        
    }
    
    // MARK: - Collision and Contact Events
    
    func didBeginContact(contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
                                                    //////////////////////////////////////////////////////////////////
                                                    // This is the contact between the character and the checkpoint //
                                                    //////////////////////////////////////////////////////////////////
        
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene after making contact and the distance between the two objects is less than 50 pixels
            // The < 60 or > - 60 helps assure that only if the distance of the two characters is less than 60 pixels away, the checkpoint will work
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                if levelChanger < 9 {
                    levelChanger += 1
                    changeScene()
                    print("This was called")
                }
                
                if levelChanger == 9 {
                    changeToTheEnd()
                }
                
                if levelChanger == 3 {
                    completedLevel1 = true
                }
            }
            
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene scene after making contact and the distance between the two objects is less than 60 pixels
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                if levelChanger < 9 {
                    levelChanger += 1
                    changeScene()
                    print("This was called")
                }
                
                if levelChanger == 9 {
                    changeToTheEnd()
                }
            }
            
                                        ////////////////////////////////////////////////////
                                        // This is the contact between the two characters //
                                        ////////////////////////////////////////////////////
            
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.BlueCharacter {
            twoBodiesMadeContact = true
            // print("DID BEGIN CONTACT")
            
                                ////////////////////////////////////////////////////////////////
                                // These two allows the contact to allow the blockade to fall //
                                ////////////////////////////////////////////////////////////////
            
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger {
            blockade?.physicsBody?.affectedByGravity = true
            fallingPlatformLvl0?.physicsBody?.affectedByGravity = true
              fallingPlatformLvl0?.physicsBody?.dynamic = true
            // print("THIS IS RUNNING")
        } else if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger {
            blockade?.physicsBody?.affectedByGravity = true
            fallingPlatformLvl0?.physicsBody?.affectedByGravity = true
            fallingPlatformLvl0?.physicsBody?.dynamic = true
            // print("THIS IS RUNNING")
        }
        
                                /////////////////////////////////////////////////////////////////
                                // These two initiates the gameOverScene when the player falls //
                                /////////////////////////////////////////////////////////////////
        
            
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger {
            if levelChanger != 2 && levelChanger != 0 {
                changeToGameOverScene()
            } else if levelChanger == 0 {
                // This is the animation for the tutorials
                triggerLvl0?.removeFromParent()
            }
            //print("GAMEOVER")
        }
            
        if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger {
            if levelChanger != 2 && levelChanger != 0 {
                changeToGameOverScene()
            } else if levelChanger == 0 {
                // Contact between the characters and the Trigger in LevelChanger = 0
                let fadeIn = SKAction.fadeInWithDuration(0.5)
                let sequence = SKAction.sequence([fadeIn])
                tapToJump?.runAction(sequence)
                tapToJump?.hidden = false
                triggerLvl0?.removeFromParent()
                // print("CONTACT MADE")
            } else if levelChanger == 2 {
                // If this is at the IntroLvl 3, this should run when it makes contact with the trigger
                let wait = SKAction.waitForDuration(1)
                let fall = SKAction.moveToY(-20, duration: 0.2)
                let sequence = SKAction.sequence([wait, fall])
                fallingPlatformLvl0?.runAction(sequence)
            }
            //print("GAMEOVER")
        }
        
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.TriggerSwitchIns {
            // Contact between the characters and the Trigger in LevelChanger = 0
//            let fadeIn = SKAction.fadeInWithDuration(0.5)
//            let sequence = SKAction.sequence([fadeIn])
//            switchInstruction.runAction(sequence)
//            switchInstruction.hidden = false
//            print("This should be deleted")
            // print("CONTACT MADE")
            triggerSwitchLvl0?.removeFromParent()
        }
        
        // This is the contact that is required to show the switchButton instruction
        if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.TriggerSwitchIns {
            // Contact between the characters and the Trigger in LevelChanger = 0
            let fadeIn = SKAction.fadeInWithDuration(0.5)
            let sequence = SKAction.sequence([fadeIn])
            switchInstruction.runAction(sequence)
            switchInstruction.hidden = false
            // print("CONTACT MADE")
            triggerSwitchLvl0?.removeFromParent()
        }
        
        if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.FallingPlatform {
            platformFall = true
        }
        
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.FallingPlatform {
            platformFall = true
        }
        
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.TransPlatform {
            platformTranslate = true
        }
        
        if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.TransPlatform {
            platformTranslate = true
        }
        
        if levelChanger == 9 {
            if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Checkpoint {
                changeToTheEnd()
            }
            if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Checkpoint {
                changeToTheEnd()
            }
        }
      
    }
    
                                    ///////////////////////////////////////////////
                                    // When two objects are no longer in contact //
                                    ///////////////////////////////////////////////
    
    func didEndContact(contact: SKPhysicsContact) {
        twoBodiesMadeContact = false
        
        // print("NO LONGER IN CONTACT")
    }
    
    // MARK: - Touches event
    
    // Note: When the screen is tapped on, this code runs
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        let cameraLocation = touch.locationInNode(characterCamera)
        
        // To remove moveInstruction from the scene
        moveInstruction?.removeAllActions()
        moveInstruction?.hidden = true
        baseInstruction.hidden = true
        baseInstruction.removeAllActions()
        tapToJump?.hidden = true
        handInstruction.hidden = true
        switchInstruction.hidden = true
        forwardAndJumpIns.hidden = true
        jumpingHand.hidden = true
        handInstruction.removeAllActions()
        
        if levelChanger == 0 {
            self.scene!.view!.paused = false
        }
        
//        if cameraLocation.x < 0 {
//        base.alpha = 0.5
//        base.hidden = false
//        base.position = cameraLocation
//        } else {
//            
//        }
        stickActive = true
//        // If the other half of the screen is tapped, this will run
//        if (CGRectContainsPoint(base.frame, cameraLocation)) {
//            stickActive = true
//        }
   
    }
    
    // This is used for detecting when a player moves their finger on the screen
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInNode(base)
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        let cameraLocation = touch.locationInNode(characterCamera)
        let moveValue: CGFloat = 50
        
        // This is for the X axis
        var x = location.x
        if x > moveValue {
            x = moveValue
        } else if x < -moveValue {
            x = -moveValue
        }
        
        // This is for the Y axis
        var y = location.y
        if y > moveValue {
            y = moveValue
        } else if y < -moveValue {
            y = -moveValue
        }
        xValue = x / moveValue
        yValue = y / moveValue
        
        //if cameraLocation.x < 0 {
            stick.position = CGPoint(x: x, y: y)
        //}
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if stickActive == true {
            let move = SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 0.1)
            move.timingMode = .EaseOut
            stick.runAction(move)
//            base.hidden = true
        }
        xValue = 0
        yValue = 0
    }
    
    // MARK: - Update Method
    
    ////////////////////
    // UPDATE METHOD ///
    ////////////////////

    override func update(currentTime: CFTimeInterval) {
        tapInstructions = -1
        // print(continueButton.hidden)
        // setupPauseButton()
        // Called before each frame is rendered
        if buttonFunctioning == true {
            if stickActive == true {
                if levelChanger == 3 {
                    let vector = CGVector(dx: 50 * xValue, dy: 0)
                    blueCharacter.physicsBody?.applyForce(vector)
                } else {
                    let vector = CGVector(dx: 200 * xValue, dy: 0)
                    blueCharacter.physicsBody?.applyForce(vector)
                }
            }
        } else {
            if stickActive == true {
                if levelChanger == 3 {
                    let vector = CGVector(dx: 50 * xValue, dy: 0)
                    pinkCharacter.physicsBody?.applyForce(vector)
                } else {
                    let vector = CGVector(dx: 200 * xValue, dy: 0)
                    pinkCharacter.physicsBody?.applyForce(vector)
                }
            }
        }
        // TODO: Make the camera move instead of jump
        if buttonFunctioning {
            characterCamera.position = blueCharacter.position
        } else if buttonFunctioning == false {
            characterCamera.position = pinkCharacter.position
        }
        // This prevents the camera from going beyond the frame
        characterCamera.position.x.clamp(92, 476)
        characterCamera.position.y.clamp(250, 52)
        
        // Calculates X the difference between the two characters
        distanceOfCharacterDifferenceX = blueCharacter.position.x - pinkCharacter.position.x
        // print("x", distanceOfCharacterDifferenceX)
        // print("BlueCharacter:", blueCharacter.position)
        // print("PinkCharacter:", pinkCharacter.position)
        
        // Calculates the Y difference between the two characters
        distanceOfCharacterDifferenceY = blueCharacter.position.y - pinkCharacter.position.y
        // print("y", distanceOfCharacterDifferenceY)
        
        // The trigger of this is if the separationExecuted == false which is found in the autoSeparate function
        if separationExecuted == false {
            reduceHealthBar()
            // bloodshotShouldRun = true
        } else if separationExecuted {
            restoreHealth()
        }

        autoSeparate()
        fallingPlatformFunction()
        fadeGreenIndicator()
        platformTranslateFunc(platformOne, yPosition: 100)
        platformTranslateFunc(platformTwo, yPosition: 120)
        platformTranslateFunc(platformThree, yPosition: 140)
        platformTranslateFunc(platformFour, yPosition: 160)
        
      }
    
    // MARK: - DidSimulatePhysics
    
    override func didSimulatePhysics() {
        connectIndicatorBlue.position = blueCharacter.position
        connectIndicatorPink.position = pinkCharacter.position
        //
        if buttonFunctioning {
            // This is when the camera follows the blueCharacter
            indicator.position = CGPoint(x: blueCharacter.position.x, y: blueCharacter.position.y + 20)
            // print("Indicator:", indicator.position)
        } else {
            // This is when the camear folllows the pinkCharacter
            indicator.position = CGPoint(x: pinkCharacter.position.x, y: pinkCharacter.position.y + 20)
            // print("Indicator:", indicator.position)
        }
    }
    
    ///////////////////////////////////////////////////////
    
    // MARK: - Functions

    ///////////////////////////////
    // Inside here are functions //
    ///////////////////////////////
    
    ///////////////////////////////
    // Function to create Chain ///
    ///////////////////////////////
    
    // The characterBack and characterFront specifices which character has a negative position to each other
    func createChain(characterBack characterBack: SKSpriteNode, characterFront: SKSpriteNode) {
        var pos = characterBack.position
        // This changes the position of the joint. If we don't use this, the joints will all be at the characterBack.position.
        pos.x += ((characterBack.position.x - characterFront.position.x) / 16) * 1.78 // 2
        pos.y -= ((characterBack.position.y - characterFront.position.y) / 16) * 1.78
        links = [SKSpriteNode]()
        for _ in 0..<8 {
            let link = SKSpriteNode(imageNamed: "link")
            link.size = CGSize(width: 2, height: 2)
            link.physicsBody = SKPhysicsBody(rectangleOfSize: link.size)
            link.physicsBody?.affectedByGravity = true
            link.zPosition = 1
            link.physicsBody?.categoryBitMask = PhysicsCategory.None
            link.physicsBody?.collisionBitMask = 0
            link.physicsBody?.contactTestBitMask = PhysicsCategory.None
            
            // In this code, the links are hidden in Level 1 because it prevents the player from seeing the links falling down when the scene spawns.
            if levelChanger == 3 {
                link.hidden = true
            }
            // This code allows the links to be visible after it's hidden because it helps the player to see that it's linked together after they press the join button
            if separationExecuted == false && levelChanger == 3 {
                link.hidden = false
                // print("LINK HIDDEN == FALSE")
            }
            
            addChild(link)
            
            link.position = pos
            pos.x -= ((characterBack.position.x - characterFront.position.x) / 16) * 1.78 // 2
            // This assures that regardless of the Y position of the two characters, the link would be targeted to the center of the character
            pos.y -= ((characterBack.position.y - characterFront.position.y) / 16) * 1.78
            links.append(link)
        }
        
        for i in 0..<links.count {
            if i == 0 {
                // This pins the joint to the pinkCharacter
                pinLinkCharacterBack = SKPhysicsJointPin.jointWithBodyA(characterBack.physicsBody!,bodyB: links.first!.physicsBody!, anchor: characterBack.position)
               
                self.physicsWorld.addJoint(pinLinkCharacterBack)
                
            } else {
                var anchorPosition = links[i].position
                anchorPosition.x -= 0.1
                // anchorPosition.y += characterBack.position.y - characterFront.position.y
                pinLink = SKPhysicsJointPin.jointWithBodyA(links[i - 1].physicsBody!,bodyB: links[i].physicsBody!, anchor: anchorPosition)
             
                self.physicsWorld.addJoint(pinLink)
            }
            
            // This pins the joint to the blueCharacter
            pinLinkCharacterFront = SKPhysicsJointPin.jointWithBodyA(characterFront.physicsBody!, bodyB: links.last!.physicsBody!, anchor: characterFront.position)
            self.physicsWorld.addJoint(pinLinkCharacterFront)
           
        }
        
    }
    
    ////////////////////////////
    // Change Level Function ///
    ////////////////////////////
    
    // This function is designed to load the level to the game
    func changeLevel(Name: String, Type: String) {
        let changeScene = SKAction.runBlock({
            let path = NSBundle.mainBundle().pathForResource(Name, ofType: Type)
            let node = SKReferenceNode (URL: NSURL (fileURLWithPath: path!))
            self.addChild(node)
        })
        self.runAction(changeScene)
    }

    ////////////////////////////
    // Activates Jump Button ///
    ////////////////////////////
    
    func activateJumpButton() {
        // Jump button allows the character to jump
        jumpButton.selectedHandler = {
            if self.buttonFunctioning {
                if self.canJump {
                    self.canJump = false
                    if levelChanger == 3 {
                        self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
                    } else {
                        self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 330))
                    }
            
                    let reset = SKAction.runBlock({
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(0.5)
                    self.runAction(SKAction.sequence([wait, reset]))
                }
            } else if self.buttonFunctioning == false {
                if self.canJump {
                    self.canJump = false
                    if levelChanger == 3 {
                        self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
                    } else {
                        self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 330))
                    }
                    
                    let reset = SKAction.runBlock({
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(0.5)
                    self.runAction(SKAction.sequence([wait, reset]))
                }
            }
        }
    }
    
    //////////////////////////////
    // Activates Switch Button ///
    //////////////////////////////
    
    func activateSwitchButton() {
        // Switch button allows the player to switch between characters
        switchButton.selectedHandler = {
            if self.buttonFunctioning {
                // Switch to the pinkCharacter
                self.buttonFunctioning = false
                // This is used to change the color of the buttons from blue to pink
                self.switchButton.texture = SKTexture(imageNamed: "pinkSwitchButton")
            } else if self.buttonFunctioning == false {
                // Switch to the blueCharacter
                self.buttonFunctioning = true
                // This is used to change the color of the buttons from pink to blue
                self.switchButton.texture = SKTexture(imageNamed: "blueSwitchButton")
            }
        }
    }
    
    ////////////////////////////////////////////////////////
    // This function changes scene when collision occurs ///
    ////////////////////////////////////////////////////////
    
    func changeScene() {
        if levelChanger <= 9 {
            // Check for max levels because the this will always increase
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 2)
            let scene = GameScene(fileNamed: arrayOfLevels[levelChanger])
            
            print("Loading Level: \(arrayOfLevels[levelChanger])")
            scene!.scaleMode = .AspectFill
            self.view?.presentScene(scene!, transition: reveal)
            // print(levelChanger)
        }
    }
    
    //////////////////////
    // Separate button ///
    //////////////////////
    
    func activateSeparateButton() {
        separateButton.selectedHandler = {
            if self.separationExecuted {
                self.removeSomeJoints()
                self.separationExecuted = false
                self.bloodshotShouldRun = true
                self.separationButtonFade()
                
                // This disables damage in IntroLvl1 so that it doesn't intimidate the players
                if levelChanger == 0 || levelChanger == 1 {
                    self.healthShouldReduce = false
                } else if levelChanger > 0 && levelChanger != 1 {
                   self.healthShouldReduce = true
                }
                
            } else if self.separationExecuted == false && self.twoBodiesMadeContact == true && abs(self.distanceOfCharacterDifferenceX) <= 17  {
                // The use of this is so that the links do not spawn backwards because the two characters have a negative difference in distance to each other.
                // print("CODE GETS THIS FAR")
                if self.distanceOfCharacterDifferenceX < 0 {
                    // If the blueChracter is behind the pinkCharacter
                    self.createChain(characterBack: self.blueCharacter, characterFront: self.pinkCharacter)
                    self.separationExecuted = true
                    self.restoreHealth()
                    self.healthShouldReduce = false
                    self.separateButton.removeAllActions()
                    
                    // print("CODE CREATES CHAIN 1")
                } else if self.distanceOfCharacterDifferenceX > 0 {
                    // If the pinkCharacter is behind the blueCharacter
                    self.createChain(characterBack: self.pinkCharacter, characterFront: self.blueCharacter)
                    self.separationExecuted = true
                    self.restoreHealth()
                    self.healthShouldReduce = false
                    self.separateButton.removeAllActions()
                    // print("CODE CREATES CHAIN 2")
                    
                }
            }
        }
    }
    
    ///////////////////////////////////
    // Function to reduce healthBar ///
    ///////////////////////////////////
    
    func reduceHealthBar() {
        if currentHealth > 0 && healthShouldReduce == true {
            currentHealth -= 0.1
            let healthBarReduce = SKAction.scaleXTo(currentHealth / maxHealth, duration: 0.5)
            healthBar.runAction(healthBarReduce)
            // print(currentHealth)
        } else if currentHealth < 0 {
            // When the health bar reaches 0
            currentHealth = 0
            changeToGameOverScene()
        } else if currentHealth == 100 {
            self.removeBloodshotEffect()
        }
    }
    
    ////////////////////////////////////
    // Function to restore healthBar ///
    ////////////////////////////////////
    
    func restoreHealth() {
        if currentHealth < 100 {
            currentHealth += 0.1
            let healthBarIncrease = SKAction.scaleXTo(currentHealth / maxHealth, duration: 0.5)
            healthBar.runAction(healthBarIncrease)
            self.removeBloodshotEffect()
        } else if currentHealth == 100 {
            self.removeBloodshotEffect()
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////
    // If the distance between the characters are too far, it removes the joint ///
    ///////////////////////////////////////////////////////////////////////////////
    
    func autoSeparate() {
        if bloodshotShouldRun == true {
            // If true no need to do the rest of this code
            return
        }
        
        if levelChanger == 0 || levelChanger == 1 {
            
        } else if abs(distanceOfCharacterDifferenceX) > 130 || abs(distanceOfCharacterDifferenceY) > 100 {
            self.removeSomeJoints()
            // SeparationExecuted is set to false because it will trigger the reduceHealth in the update moethod
            self.separationExecuted = false
            // This is set to true so that it triggers the bloodshot effect
        }
        
        // This is in Level 1
        if levelChanger == 3 {
            self.bloodshotShouldRun = false
            self.healthShouldReduce = false
            // print("THE PROBLEM IS HERE")
        } else if levelChanger == 0 {
            self.bloodshotShouldRun = false
            self.healthShouldReduce = false
        } else if levelChanger == 1 {
            self.bloodshotShouldRun = false
            self.healthShouldReduce = false
        }
        
        if separationExecuted == false && levelChanger != 3 {
            self.bloodshotShouldRun = true
            self.healthShouldReduce = true
            separationButtonFade()
            // print("THIS IS BEING CALLED")
            // print(bloodshotShouldRun)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // If the character is losing health, this helps show this. It stops running when healthRestore ///
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    func bloodshotEffect() {
        self.bloodshot.hidden = false
        // separationExecuted = true
        // let firstDisappear = SKAction.fadeOutWithDuration(0.1)
        let flashIn = SKAction.fadeInWithDuration(1)
        let flashOut = SKAction.fadeOutWithDuration(1)
        let sequence = SKAction.sequence([flashIn, flashOut])
        self.bloodshot.runAction(SKAction.repeatActionForever(sequence))
        print("THE BLOODSHOT EFFECT IS BEING CALLED")
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    // This removes the bloodshot effect when the character is connected or restoring health ///
    ////////////////////////////////////////////////////////////////////////////////////////////
    
    func removeBloodshotEffect() {
        let fadeOut = SKAction.fadeOutWithDuration(1)
        self.bloodshot.runAction(SKAction.sequence([fadeOut]))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////
    // The game switches to gameOverScene when the character fails to hit the checkpoint ///
    ////////////////////////////////////////////////////////////////////////////////////////
    
    func changeToGameOverScene() {
        runAction(SKAction.sequence([
            SKAction.waitForDuration(0),
            SKAction.runBlock() {
                //print("CHANGING SCENE")
                let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
                let scene = GameOverScene(size: self.size)
                scene.scaleMode = .AspectFill
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    // This function removes three joints so that when the button is pressed, only these will be removed ///
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func removeSomeJoints() {
        self.physicsWorld.removeJoint(self.pinLinkCharacterFront)
        self.physicsWorld.removeJoint(self.pinLinkCharacterBack)
        self.physicsWorld.removeJoint(self.pinLink)
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    // This function allows the platform at Level 5 to fall down after one second ///
    /////////////////////////////////////////////////////////////////////////////////
    
    func fallingPlatformFunction() {
        if platformFall == true {
            let wait = SKAction.waitForDuration(1)
            let fall = SKAction.moveToY(-20, duration: 0.2)
            let sequence = SKAction.sequence([wait, fall])
            fallingPlatform?.runAction(sequence)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // This function allows the platform at Level 7 to raise after 3 seconds ///
    ////////////////////////////////////////////////////////////////////////////
    
    func platformTranslateFunc(platform: SKSpriteNode?, yPosition: CGFloat) {
        if platformTranslate == true {
            // Platform 1
            let wait = SKAction.waitForDuration(1)
            let translate = SKAction.moveToY(yPosition, duration: 1.5)
            let sequence = SKAction.sequence([wait, translate])
            platform?.runAction(sequence)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////
    // This function allows the level to restart and the level to end to the final scene ///
    ////////////////////////////////////////////////////////////////////////////////////////
    
    func changeToTheEnd() {
        /// changeToTheEnd: Its something
        runAction(SKAction.sequence([
            SKAction.waitForDuration(0),
            SKAction.runBlock() {
                //print("CHANGING SCENE")
                let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
                let scene = TheEnd(size: self.size)
                scene.scaleMode = .AspectFill
                self.view?.presentScene(scene, transition:reveal)
                levelChanger = 0
            }
            ]))
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    // This allows the greenIndicator to be seen when the distance of the character is close ///
    ////////////////////////////////////////////////////////////////////////////////////////////
    
    func fadeGreenIndicator() {
        if abs(distanceOfCharacterDifferenceX) < 17 && abs(distanceOfCharacterDifferenceY) < 17 {
            let fadeInIndicator = SKAction.fadeInWithDuration(0.5)
            connectIndicatorBlue.runAction(fadeInIndicator)
            connectIndicatorPink.runAction(fadeInIndicator)
        // The separation button flashes to help the players see recognize the button
            
        } else {
            let fadeInIndicator = SKAction.fadeOutWithDuration(0.5)
            connectIndicatorBlue.runAction(fadeInIndicator)
            connectIndicatorPink.runAction(fadeInIndicator)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////
    // This allows the separationButton to flash through fadeIn and fadeOut ///
    ///////////////////////////////////////////////////////////////////////////
    
    func separationButtonFade() {
        let flashOut = SKAction.fadeOutWithDuration(0.5)
        let flashIn = SKAction.fadeInWithDuration(0.5)
        let sequence = SKAction.sequence([flashOut, flashIn])
        separateButton.runAction(SKAction.repeatActionForever(sequence))
    }
    
    func setupPauseButton() {
        pauseButton.selectedHandler = {
            let wait = SKAction.waitForDuration(0.1)
            let reveal = SKAction.fadeInWithDuration(0.1)
            let show = SKAction.runBlock({
                self.continueButton.hidden = false
                self.pauseMenu.hidden = false
                self.homeButton.hidden = false
            })
            let pause = SKAction.runBlock({
                  self.scene!.view!.paused = true
            })
            let sequence = SKAction.sequence([show, reveal, wait, pause])
            self.pauseMenu.runAction(sequence)
        }
    }
    
    func setupPlayButton() {
        continueButton.selectedHandler = {
            self.scene?.view?.paused = false
            self.continueButton.hidden = true
            self.continueButton.alpha = 0
            self.pauseMenu.hidden = true
            self.pauseMenu.alpha = 0
            self.homeButton.hidden = true
        }
    }
    
    func setupHomeButton() {
        homeButton.selectedHandler = {
            self.scene!.view!.paused = false
            levelChanger = 0
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 2)
            let scene = MenuScene(fileNamed: "MenuScene")
            scene!.scaleMode = .AspectFill
            self.view!.presentScene(scene!, transition: reveal)
      }
    }
}
