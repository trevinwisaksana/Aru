//
//  GameScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//  In GameScene, only place the Gaming properties and attributes. Place different levels in different scenes or different states as a state machine is set up.


import SpriteKit
// TODO: GREEN INDICATOR SHOULD NOT BE PLACED IN THE UPDATE
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

// Used to keep track which level is completed to unlock the level
var completedLevel1: Bool = false
var completedLevel2: Bool = false
var completedLevel3: Bool = false
var completedLevel4: Bool = false
var completedLevel5: Bool = false
var completedLevel6: Bool = false
var completedLevel7: Bool = false

// Death counter object
var level1DeathCount: Int = 0
var level2DeathCount: Int = 0
var level3DeathCount: Int = 0
var level4DeathCount: Int = 0
var level5DeathCount: Int = 0
var level6DeathCount: Int = 0
var level7DeathCount: Int = 0

// MARK: - GameScene Class

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Creating the background 
    var background: SKSpriteNode!
    
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
    var flash = SKSpriteNode(imageNamed: "flash")
    var alreadyHidden: Bool = false
    
    // Declaring the play button objects
    var switchButton: MSButtonNode!
    var buttonFunctioning: Bool = true
    var jumpButton: MSButtonNode!
    var alreadyTapped: Bool = true
    var anchorButton: MSButtonNode!
    var alreadyAnchored: Bool = false
    
    // MARK: - Control Button Properties
    // Declaring pauseButton object
    var pauseButton: MSButtonNode!
    var continueButton: MSButtonNode!
    
    // Allows the button to be pressed once every 1 second
    var canJump = true
    
    // Array to contain the links of the joints
    var links: [SKSpriteNode]!
    var pinJoints = [SKPhysicsJointPin]()
    var pinLinkCharacterFront: SKPhysicsJointPin!
    var pinLinkCharacterFront2: SKPhysicsJointPin!
    var pinLinkCharacterBack: SKPhysicsJointPin!
    var pinLink: SKPhysicsJointPin!
    var locked: Bool = true
    
    // Creating the checkpoint object
    var target: Checkpoint!
    
    // X and Y Distance between each character
    var distanceOfCharacterDifferenceX: CGFloat!
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
    // var checkpointActiveIndicator = SKSpriteNode(imageNamed: "checkpointInactive")
    
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
    var connectInstruciton = SKSpriteNode(imageNamed: "connectInstruction")
    // var forwardAndJumpIns = SKSpriteNode(imageNamed: "forwardAndJumpIns")
    var forwardAndJumpIns: SKSpriteNode!
    var workTogetherInstruction = SKSpriteNode(imageNamed: "workTogetherInstruction")
    var warning = SKSpriteNode(imageNamed: "warning")
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
    
    // Creating cutscenes 
    var cutSceneOne = SKSpriteNode(imageNamed: "letMeIntroduce") // 1
    var cutSceneTwo = SKSpriteNode(imageNamed: "youreReady") // 2
    var cutSceneThree = SKSpriteNode(imageNamed: "dayYouMet") // 3
    var cutSceneFour = SKSpriteNode(imageNamed: "youBeginToBond") // 4
    var cutSceneFive = SKSpriteNode(imageNamed: "bridgingTrust") // 5
    var cutSceneSix = SKSpriteNode(imageNamed: "showCommittment") // 6
    var cutSceneSeven = SKSpriteNode(imageNamed: "cutSceneSeven")
    var chooseLeftOrRight = SKSpriteNode(imageNamed: "chooseLeftOrRight")
    var wrongChoice = SKSpriteNode(imageNamed: "wrongChoice")
    var trustChallenge = SKSpriteNode(imageNamed: "trustChallenge")
    var challengedAgain = SKSpriteNode(imageNamed: "challengedAgain")
    var allIsOver = SKSpriteNode(imageNamed: "allIsOver")
    
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
    
    // Creating anchor to stop the player from moving 
    var anchorObject: SKSpriteNode!

    
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
        bloodshot = SKSpriteNode(imageNamed: "bloodshot")
        bloodshot.size = CGSize(width: view.frame.width, height: view.frame.height)
        bloodshot.position = CGPoint(x: 0, y: 0)
        bloodshot.hidden = true
        bloodshot.zPosition = 95
        characterCamera.addChild(bloodshot)
        
        ///////////////////////////
        /// Creating Health Bar ///
        ///////////////////////////
        healthBar.position = CGPoint(x: frame.width * -0.459, y: frame.height * 0.43)
        healthBar.zPosition = 4
        healthBar.anchorPoint.x = 0
        //print(healthBar.position)
        
        /////////////////////////////
        /// Creating Pause Button ///
        /////////////////////////////
        pauseButton = MSButtonNode(imageNamed: "pauseButton")
        pauseButton.size = CGSize(width: pauseButton.size.width / 2, height: pauseButton.size.height / 2)
        pauseButton.position = CGPoint(x: frame.width * 0.44, y: frame.height * 0.43)
        pauseButton.zPosition = 120
        pauseButton.state = .Active
        characterCamera.addChild(pauseButton)
        setupPauseButton()
        
        //////////////////////////
        /// Creating pauseMenu ///
        //////////////////////////
        pauseMenu = SKSpriteNode(imageNamed: "pauseMenu")
        pauseMenu.position = CGPoint(x: -40, y: -50)
        pauseMenu.size = CGSize(width: pauseMenu.size.width / 1, height: pauseMenu.size.height / 1)
        pauseMenu.zPosition = 120
        pauseMenu.alpha = 0
        pauseMenu.hidden = true
        pauseButton.addChild(pauseMenu)
        
        ////////////////////////////
        /// Creating Play Button ///
        ////////////////////////////
        continueButton = MSButtonNode(imageNamed: "continueToPlayButton")
        continueButton.size = CGSize(width: continueButton.size.width / 1.5, height: continueButton.size.height / 1.5)
        continueButton.position = CGPoint(x: -15, y: -10)
        continueButton.zPosition = 1000
        continueButton.state = .Active
        continueButton.hidden = true
        pauseMenu.addChild(continueButton)
        setupPlayButton()
        
        ////////////////////////////
        /// Creating Home Button ///
        ////////////////////////////
        homeButton = MSButtonNode(imageNamed: "homeButton")
        homeButton.position = CGPoint(x: -50, y: 50)
        homeButton.size = CGSize(width: homeButton.size.width / 1.5, height: homeButton.size.height / 1.5)
        homeButton.zPosition = 1000
        homeButton.state = .Active
        homeButton.hidden = true
        pauseMenu.addChild(homeButton)
        setupHomeButton()
        
        ///////////////////////////
        /// Creating indicator  ///
        ///////////////////////////
        indicator = SKSpriteNode(imageNamed: "indicator")
        indicator.size = CGSize(width: self.size.width / 10, height: self.size.height / 9)
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
        base.position.x = view.frame.width * -0.35
        base.position.y = view.frame.height * -0.25
        base.alpha = 0.5
        
        stick = SKSpriteNode(imageNamed: "base")
        stick.size = CGSize(width: 80, height: 80)
        base.addChild(stick)
        
        ////////////////////////////
        /// Creating instructions //
        ////////////////////////////
        
        // WARNING INSTRUCTION
        warning.zPosition = 100
        warning.size = CGSize(width: warning.size.width / 3, height: warning.size.height / 3)
        warning.alpha = 1
        warning.hidden = true
        warning.position = CGPoint(x: 150, y: 0)
        characterCamera.addChild(warning)
        
        ////////////////////////////////////////////////////////////
        /// Creating different positions for spawning the players //
        ////////////////////////////////////////////////////////////
        // This is a list of the different positions of the characters
        // MARK: - Level Character Positions
        switch levelChanger {
        case 0:
            // This is introLevel1
            blueCharacter.position = CGPoint(x: 60, y: 200)
            pinkCharacter.position = CGPoint(x: 50, y: 200)
            
            background = SKSpriteNode(imageNamed: "backgroundLvl1")
            
            // Another trigger at Level 0. This trigger shows the switch button instruciton
            triggerSwitchLvl0 = childNodeWithName("//triggerSwitchLvl0") as? SKSpriteNode
            triggerSwitchLvl0?.physicsBody = SKPhysicsBody(rectangleOfSize: (triggerSwitchLvl0?.size)!)
            triggerSwitchLvl0?.physicsBody?.categoryBitMask = PhysicsCategory.TriggerSwitchIns
            triggerSwitchLvl0?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
            triggerSwitchLvl0?.physicsBody?.collisionBitMask = PhysicsCategory.None
            triggerSwitchLvl0?.physicsBody?.affectedByGravity = false
            
            baseInstruction.zPosition = 101
            baseInstruction.size = CGSize(width: 50, height: 50)
            baseInstruction.alpha = 1
            baseInstruction.hidden = true
            baseInstruction.position = CGPoint(x: -100, y: -100)
            characterCamera.addChild(baseInstruction)
            
            // STICK INSTRUCTION ATTRIBUTE
            stickInstruction.zPosition = 102
            stickInstruction.size = CGSize(width: 40, height: 40)
            stickInstruction.alpha = 1
            stickInstruction.position = CGPoint(x: 0, y: 0)
            baseInstruction.addChild(stickInstruction)
            
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
            
            switch view.frame.size {
            case CGSize(width: 480, height: 320):
                // Switch Instruction which appears when making contact with trigger
                switchInstruction.zPosition = 100
                switchInstruction.size = CGSize(width: switchInstruction.size.width / 3, height: switchInstruction.size.height / 3)
                switchInstruction.alpha = 1
                switchInstruction.hidden = true
                switchInstruction.position = CGPoint(x: -80, y: -10)
                characterCamera.addChild(switchInstruction)
                
                // Tap to Jump instruciton appears
                forwardAndJumpIns = SKSpriteNode(imageNamed: "tapToJump")
                forwardAndJumpIns.zPosition = 100
                forwardAndJumpIns.size = CGSize(width: forwardAndJumpIns.size.width / 3.2, height: forwardAndJumpIns.size.height / 3.2)
                forwardAndJumpIns.alpha = 0
                forwardAndJumpIns.position = CGPoint(x: 0, y: 100)
                characterCamera.addChild(forwardAndJumpIns)
                // moveInstruction?.hidden = false
                
                // Move instruction which appears during the start of the game
                moveInstruction = SKSpriteNode(imageNamed: "moveInstruction")
                moveInstruction?.zPosition = 100
                moveInstruction?.size = CGSize(width: moveInstruction!.size.width / 3.2, height: moveInstruction!.size.height / 3.2)
                moveInstruction?.alpha = 0
                moveInstruction?.position = CGPoint(x: -100, y: -10)
                characterCamera.addChild(moveInstruction!)
                // moveInstruction?.hidden = false
                
                // This is the "Let me show you how things work"
                setupInstructions(cutSceneOne, positionX: frame.width * 0.09, positionY: 0, alpha: 1, zPosition: 1000, width: cutSceneOne.size.width / 3.35, height: cutSceneOne.size.height / 3.35)
                
            default:
                // Switch Instruction which appears when making contact with trigger
                switchInstruction.zPosition = 100
                switchInstruction.size = CGSize(width: switchInstruction.size.width / 3, height: switchInstruction.size.height / 3)
                switchInstruction.alpha = 1
                switchInstruction.hidden = true
                switchInstruction.position = CGPoint(x: -120, y: -10)
                characterCamera.addChild(switchInstruction)
                
                // Tap to Jump instruction appears
                forwardAndJumpIns = SKSpriteNode(imageNamed: "tapToJump")
                forwardAndJumpIns.zPosition = 100
                forwardAndJumpIns.size = CGSize(width: forwardAndJumpIns.size.width / 3.2, height: forwardAndJumpIns.size.height / 3.2)
                forwardAndJumpIns.alpha = 0
                forwardAndJumpIns.position = CGPoint(x: 155, y: 3)
                characterCamera.addChild(forwardAndJumpIns)
                // moveInstruction?.hidden = false
                
                // Move instruction which appears during the first few seconds in the game
                moveInstruction = SKSpriteNode(imageNamed: "moveInstruction")
                moveInstruction?.zPosition = 100
                moveInstruction?.size = CGSize(width: moveInstruction!.size.width / 3.2, height: moveInstruction!.size.height / 3.2)
                moveInstruction?.alpha = 0
                moveInstruction?.position = CGPoint(x: -130, y: -10)
                characterCamera.addChild(moveInstruction!)
                // moveInstruction?.hidden = false
                
                // This is the "Let me show you how things work"
                setupInstructions(cutSceneOne, positionX: 0, positionY: 0, alpha: 1, zPosition: 1000, width: view.frame.width * 1, height: view.frame.height * 1)
                
            }
            
            let instructionsShow = SKAction.runBlock({
                
                self.userInteractionEnabled = true
                
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
                self.handInstruction.runAction(SKAction.repeatActionForever(sequenceHand))
                
                // Tutorial objects and properties
                let fadeIn = SKAction.fadeInWithDuration(0.5)
                let sequence = SKAction.sequence([fadeIn])
                self.moveInstruction?.runAction(sequence)
                
                // Tutorial objects and properties
                self.forwardAndJumpIns.hidden = false
                self.jumpingHand.hidden = false
                let fadeInJump = SKAction.fadeInWithDuration(0.5)
                let sequenceJump = SKAction.sequence([fadeInJump])
                self.forwardAndJumpIns.runAction(sequenceJump)
                
                // Jumping Hand Animation
                self.jumpingHand.alpha = 1
                let jumpHandScaleBig = SKAction.scaleTo(1.5, duration: 1)
                let jumpHandScaleSmall = SKAction.scaleTo(1, duration: 1)
                let jumpHandSequence = SKAction.sequence([jumpHandScaleBig, jumpHandScaleSmall])
                self.jumpingHand.runAction(SKAction.repeatActionForever(jumpHandSequence))
                
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
                self.baseInstruction.runAction(SKAction.repeatActionForever(baseSeq))
                
                let stickWait = SKAction.waitForDuration(0.5)
                let start = SKAction.moveToX(0, duration: 0.7)
                let move = SKAction.moveToX(60, duration: 1)
                let hide = SKAction.runBlock({
                    self.stickInstruction.hidden = true
                })
                let hideFalse = SKAction.runBlock({
                    self.stickInstruction.hidden = false
                })
                self.stickInstruction.runAction(SKAction.repeatActionForever(SKAction.sequence([stickWait, move, hide, start, hideFalse])))

            })
            
            let cutSceneOneShow = SKAction.runBlock({
                let showCutScene = SKAction.fadeInWithDuration(1)
                self.cutSceneOne.hidden = false
                let waitToShow = SKAction.waitForDuration(1)
                let showScene = SKAction.fadeOutWithDuration(0.5)
                let seq = SKAction.sequence([showCutScene, waitToShow, showScene])
                self.cutSceneOne.runAction(seq)
                self.userInteractionEnabled = false
            })
            
            let sequence = SKAction.sequence([cutSceneOneShow, instructionsShow])
            
            runAction(sequence)
        
            
        case 1:
            // This is introLevel2
            blueCharacter.position = CGPoint(x: 170, y: 200)
            pinkCharacter.position = CGPoint(x: 160, y: 200)
            
            background = SKSpriteNode(imageNamed: "backgroundLvl1")
            
            switch view.frame.size {
            case CGSize(width: 480, height: 320):
                workTogetherInstruction.zPosition = 100
                workTogetherInstruction.size = CGSize(width: workTogetherInstruction.size.width / 3, height: workTogetherInstruction.size.height / 3)
                workTogetherInstruction.alpha = 0
                workTogetherInstruction.hidden = true
                workTogetherInstruction.position = CGPoint(x: -90, y: -10)
                characterCamera.addChild(workTogetherInstruction)
            default:
                workTogetherInstruction.zPosition = 100
                workTogetherInstruction.size = CGSize(width: workTogetherInstruction.size.width / 3, height: workTogetherInstruction.size.height / 3)
                workTogetherInstruction.alpha = 0
                workTogetherInstruction.hidden = true
                workTogetherInstruction.position = CGPoint(x: -120, y: -10)
                characterCamera.addChild(workTogetherInstruction)
            }
            
            fadeInAndFadeOut(workTogetherInstruction)
        
        case 2:
            // This is introLevel3
            blueCharacter.position = CGPoint(x: 160, y: 175)
            pinkCharacter.position = CGPoint(x: 150, y: 175)
            
            background = SKSpriteNode(imageNamed: "backgroundLvl1")
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is the "You're ready to being this journey"
                setupInstructions(cutSceneTwo, positionX: -90, positionY: 0, alpha: 0, zPosition: 150, width: cutSceneTwo.size.width / 3.35, height: cutSceneTwo.size.width / 3.35)
            } else {
                // This is the "You're ready to being this journey"
                setupInstructions(cutSceneTwo, positionX: 0, positionY: 0, alpha: 0, zPosition: 150, width: view.frame.width * 1, height: view.frame.height * 1)
            }
        
            // Creates falling platform
            fallingPlatformLvl0 = childNodeWithName("//fallingPlatformLvl2") as? SKSpriteNode
            fallingPlatformLvl0?.physicsBody?.dynamic = false
            fallingPlatformLvl0?.physicsBody?.affectedByGravity = false
            fallingPlatformLvl0?.physicsBody?.allowsRotation = false
            
            // Creating Trigger that will cause the blockade to drop
            trigger = childNodeWithName("//trigger") as? SKSpriteNode
            trigger?.physicsBody = SKPhysicsBody(rectangleOfSize: (trigger?.size)!)
            trigger?.physicsBody?.categoryBitMask = PhysicsCategory.Trigger
            trigger?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
            trigger?.physicsBody?.collisionBitMask = PhysicsCategory.None
            trigger?.physicsBody?.affectedByGravity = false
            
            // Blockade drops when the character makes contact with the trigger
            blockade = childNodeWithName("//blockade") as? SKSpriteNode
            blockade?.physicsBody?.affectedByGravity = false
            blockade?.physicsBody?.allowsRotation = false
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // CONNECT INSTRUCTION ATTRIBUTE
                connectInstruciton.zPosition = 102
                connectInstruciton.size = CGSize(width: connectInstruciton.size.width / 3, height: connectInstruciton.size.height / 3)
                connectInstruciton.alpha = 1
                connectInstruciton.position = CGPoint(x: -130, y: -20)
                connectInstruciton.hidden = true
                characterCamera.addChild(connectInstruciton)
            } else {
                // CONNECT INSTRUCTION ATTRIBUTE
                connectInstruciton.zPosition = 102
                connectInstruciton.size = CGSize(width: connectInstruciton.size.width / 3, height: connectInstruciton.size.height / 3)
                connectInstruciton.alpha = 1
                connectInstruciton.position = CGPoint(x: -120, y: -20)
                connectInstruciton.hidden = true
                characterCamera.addChild(connectInstruciton)
            }
            
        case 3:
            // This is Level 1
            blueCharacter.position = CGPoint(x: 520, y: 260)
            pinkCharacter.position = CGPoint(x: 50, y: 260)
            blueCharacter.physicsBody?.linearDamping = 1
            pinkCharacter.physicsBody?.linearDamping = 1
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
            // If the iPhone is a 4s
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is the "Day we met" cut scene
                setupInstructions(cutSceneThree, positionX: frame.width * 0.09, positionY: -95, alpha: 0, zPosition: 90, width: cutSceneThree.size.width / 3.35, height: cutSceneThree.size.height / 3.35)
            } else {
                // This is the "Day we met" cut scene
                setupInstructions(cutSceneThree, positionX: -5, positionY: -95, alpha: 0, zPosition: 90, width: cutSceneThree.size.width / 3.35, height: cutSceneThree.size.height / 3.35)
            }
            
            // If the iPhone is a 4s
            if view.frame.size == CGSize(width: 480, height: 320) {
                // You begin to bond together
                setupInstructions(cutSceneFour, positionX: 30, positionY: 0, alpha: 0, zPosition: 1000, width: cutSceneFour.size.width / 3.35, height: cutSceneFour.size.height / 3.35)
            } else {
                // You begin to bond together
                setupInstructions(cutSceneFour, positionX: 0, positionY: 0, alpha: 0, zPosition: 1000, width: view.frame.width * 1, height: view.frame.height * 1)
            }
            
            fadeInAndFadeOut(cutSceneThree)
            
        case 4:
            // This is Level 2
            blueCharacter.position = CGPoint(x: 60, y: 175)
            pinkCharacter.position = CGPoint(x: 50, y: 175)
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is the "We began bridging our trust"
                setupInstructions(cutSceneFive, positionX: 30, positionY: -10, alpha: 0, zPosition: 90, width: cutSceneFive.size.width / 3.35, height: cutSceneFive.size.height / 3.35)
            } else {
                // This is the "We began bridging our trust"
                setupInstructions(cutSceneFive, positionX: -10, positionY: -10, alpha: 0, zPosition: 90, width: cutSceneFive.size.width / 3.35, height: cutSceneFive.size.height / 3.35)
            }
            
            fadeInAndFadeOut(cutSceneFive)
            
        case 5:
            // This is Level 3
            blueCharacter.position = CGPoint(x: 50, y: 100)
            pinkCharacter.position = CGPoint(x: 40, y: 100)
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is the "We're committed to each other, work together"
                setupInstructions(cutSceneSix, positionX: 30, positionY: -10, alpha: 0, zPosition: 90, width: cutSceneSix.size.width / 3.35, height: cutSceneSix.size.height / 3.35)
            } else {
                // This is the "We're committed to each other, work together"
                setupInstructions(cutSceneSix, positionX: -10, positionY: -10, alpha: 0, zPosition: 90, width: cutSceneSix.size.width / 3.35, height: cutSceneSix.size.height / 3.35)
            }
            
            // Setting up the position of the cutSceneSeven
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is the "But in the end every choice will determine our future"
                setupInstructions(cutSceneSeven, positionX: 0, positionY: 0, alpha: 1, zPosition: 1000, width: cutSceneSeven.size.width / 3.35, height: cutSceneSeven.size.height / 3.35)
            } else {
                // This is the "But in the end every choice will determine our future"
                setupInstructions(cutSceneSeven, positionX: 0, positionY: 0, alpha: 1, zPosition: 1000, width: cutSceneSeven.size.width / 3.35, height: cutSceneSeven.size.height / 3.35)
            }
            
            fadeInAndFadeOut(cutSceneSix)
            
        case 6:
            // This is Level 4
            blueCharacter.position = CGPoint(x: 280, y: 274)
            pinkCharacter.position = CGPoint(x: 270, y: 274)
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // Choose left or right statement
                setupInstructions(chooseLeftOrRight, positionX: 30, positionY: -10, alpha: 0, zPosition: 90, width: chooseLeftOrRight.size.width / 3.35, height: chooseLeftOrRight.size.height / 3.35)
            } else {
                // Choose left or right statement
                setupInstructions(chooseLeftOrRight, positionX: -10, positionY: -10, alpha: 0, zPosition: 90, width: chooseLeftOrRight.size.width / 3.35, height: chooseLeftOrRight.size.height / 3.35)
            }
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // When triggered "You've made the wrong choice"
                setupInstructions(wrongChoice, positionX: 30, positionY: -10, alpha: 0, zPosition: 90, width: wrongChoice.size.width / 3.35, height: wrongChoice.size.height / 3.35)
                // TODO: MAKE THE TRIGGER FOR THE WRONG CHIOCE
            } else {
                // When triggered "You've made the wrong choice"
                setupInstructions(wrongChoice, positionX: -10, positionY: -10, alpha: 0, zPosition: 90, width: wrongChoice.size.width / 3.35, height: wrongChoice.size.height / 3.35)
                // TODO: MAKE THE TRIGGER FOR THE WRONG CHIOCE
            }
            
            fadeInAndFadeOut(chooseLeftOrRight)
            
        case 7:
            // This is Level 5
            blueCharacter.position = CGPoint(x: 60, y: 260)
            pinkCharacter.position = CGPoint(x: 50, y: 260)
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
            // Creating fallingPlatform
            fallingPlatform = childNodeWithName("//fallingPlatform") as? SKSpriteNode
            fallingPlatform?.physicsBody?.categoryBitMask = PhysicsCategory.FallingPlatform | PhysicsCategory.BlueCharacter
            fallingPlatform?.physicsBody?.collisionBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
            fallingPlatform?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
            
            movingPlatform = childNodeWithName("//movingPlatform") as! SKSpriteNode
            let moveLeft = SKAction.moveToX(100, duration: 4)
            let moveRight = SKAction.moveToX(192, duration: 4)
            self.movingPlatform.runAction(SKAction.repeatActionForever(SKAction.sequence([moveLeft, moveRight])))
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // OFTEN YOUR TRUST WILL BE CHALLENGED
                setupInstructions(trustChallenge, positionX: 30, positionY: -5, alpha: 0, zPosition: 90, width: trustChallenge.size.width / 3.35, height: trustChallenge.size.height / 3.35)
            } else {
                // OFTEN YOUR TRUST WILL BE CHALLENGED
                setupInstructions(trustChallenge, positionX: -10, positionY: -5, alpha: 0, zPosition: 90, width: trustChallenge.size.width / 3.35, height: trustChallenge.size.height / 3.35)
            }
            
            fadeInAndFadeOut(trustChallenge)
            
        case 8:
            // This is Level 6
            blueCharacter.position = CGPoint(x: 60, y: 300)
            pinkCharacter.position = CGPoint(x: 50, y: 300)
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is the challenged again cut scene
                setupInstructions(challengedAgain, positionX: 30, positionY: 10, alpha: 0, zPosition: 90, width: challengedAgain.size.width / 3.35, height: challengedAgain.size.height / 3.35)
            } else {
                // This is the challenged again cut scene
                setupInstructions(challengedAgain, positionX: -10, positionY: 10, alpha: 0, zPosition: 90, width: challengedAgain.size.width / 3.35, height: challengedAgain.size.height / 3.35)
            }
            
            fadeInAndFadeOut(challengedAgain)
            
        case 9:
            // This is Level 7
            blueCharacter.position = CGPoint(x: 60, y: 150)
            pinkCharacter.position = CGPoint(x: 50, y: 150)
            platformOne = childNodeWithName("1") as? SKSpriteNode
            platformTwo = childNodeWithName("2") as? SKSpriteNode
            platformThree = childNodeWithName("3") as? SKSpriteNode
            platformFour = childNodeWithName("4") as? SKSpriteNode
            
            background = SKSpriteNode(imageNamed: "menuBackground")
            
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
            
            if view.frame.size == CGSize(width: 480, height: 320) {
                // This is when all is over for the final scene
                setupInstructions(allIsOver, positionX: 30, positionY: 10, alpha: 10, zPosition: 90, width: allIsOver.size.width / 3.35, height: allIsOver.size.height / 3.35)
            } else {
                // This is when all is over for the final scene
                setupInstructions(allIsOver, positionX: -10, positionY: 10, alpha: 10, zPosition: 90, width: allIsOver.size.width / 3.35, height: allIsOver.size.height / 3.35)
            }
            
            fadeInAndFadeOut(allIsOver)
            
        default:
            background = SKSpriteNode(imageNamed: "menuBackground")
            
        }
        
        // Creating background
        background.size = CGSize(width: view.frame.width * 2, height: view.frame.height * 2)
        background.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        background.zPosition = -2
        addChild(background)
        
        // Creating flash effect 
        flash.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        flash.zPosition = 150
        flash.size = CGSize(width: flash.size.width, height: flash.size.height)
        flash.alpha = 0
        addChild(flash)
        
        // Creating Trigger that will cause gameOver
        trigger = childNodeWithName("//trigger") as? SKSpriteNode
        trigger?.physicsBody = SKPhysicsBody(rectangleOfSize: (trigger?.size)!)
        trigger?.physicsBody?.categoryBitMask = PhysicsCategory.Trigger
        trigger?.physicsBody?.contactTestBitMask = PhysicsCategory.BlueCharacter | PhysicsCategory.PinkCharacter
        trigger?.physicsBody?.collisionBitMask = PhysicsCategory.None
        trigger?.physicsBody?.affectedByGravity = false
        
        ////////////////////////////////////
        /// These are buttons properties ///
        ////////////////////////////////////
        
        // Creates the jump and switch button
        switchButton = MSButtonNode(imageNamed: "blueSwitchButton")
        switchButton.size = CGSize(width: switchButton.size.width / 7, height: switchButton.size.height / 7)
        switchButton.zPosition = 106
        switchButton.position.x = view.frame.width * 0.2
        switchButton.position.y = view.frame.height * -0.3
        
        // Creating jump button
        jumpButton = MSButtonNode(color: SKColor.clearColor(), size: CGSize(width: self.frame.width / 2, height: self.frame.height))
        jumpButton.position.x = 142
        jumpButton.position.y = 0
        jumpButton.zPosition = 98
        
        // Creating anchor button 
        anchorButton = MSButtonNode(imageNamed: "blueAnchor")
        anchorButton.size = CGSize(width: anchorButton.size.width / 7, height: anchorButton.size.height / 7)
        anchorButton.zPosition = 106
        anchorButton.position.x = view.frame.width * 0.4
        anchorButton.position.y = view.frame.height * 0.1
        
        // Creating Separate Button
        separateButton = MSButtonNode(imageNamed: "separateBlueButton")
        separateButton.size = CGSize(width: separateButton.size.width / 1.5, height: separateButton.size.height / 1.5)
        separateButton.zPosition = 106
        separateButton.position = CGPoint(x: view.frame.width * 0.01, y: view.frame.height * -0.3)
        
        // Button States
        if levelChanger == 0 {
            separateButton.state = .Inactive
        } else {
            separateButton.state = .Active
        }
        
        switchButton.state = .Active
        jumpButton.state = .Active
        anchorButton.state = .Active
        
        // Adding the camera as the button's parent so that it follows its position
        characterCamera.addChild(switchButton)
        characterCamera.addChild(jumpButton)
        characterCamera.addChild(base)
        characterCamera.addChild(separateButton)
        characterCamera.addChild(healthBar)
        characterCamera.addChild(anchorButton)
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
        setupAnchorButton()
    
        // Creating a physical boundary to the edge of the scene
        if view.frame.size == CGSize(width: 480, height: 320) {
            physicsBody = SKPhysicsBody(edgeLoopFromRect: background.frame)
        } else {
            physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        }
        physicsBody?.categoryBitMask = PhysicsCategory.Platform
        physicsBody?.collisionBitMask = 1
        
        if levelChanger == 0 || levelChanger == 1 {
            self.separateButton.state = .Inactive
        }
        
        let backgroundMusic = SKAction.playSoundFileNamed("YouthfulDreams.mp3", waitForCompletion: true)
        runAction(SKAction.repeatActionForever(backgroundMusic))
        
    }
    
    // MARK: - Collision and Contact Events
    
    func didBeginContact(contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
            //////////////////////////////////////////////////////////////////
            // This is the contact between the character and the checkpoint //
            //////////////////////////////////////////////////////////////////
        
        switch collision {
            
        // WHEN THE BLUE CHARACTER MAKES CONTACT WITH THE CHECKPOINT THIS HAPPENS
        case PhysicsCategory.BlueCharacter | PhysicsCategory.Checkpoint:
            // This goes to the LevelCompleteScene after making contact and the distance between the two objects is less than 50 pixels
            // The < 60 or > - 60 helps assure that only if the distance of the two characters is less than 60 pixels away, the checkpoint will work
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                if levelChanger <= 9 {
                    switch levelChanger {
                    case 0:
                        levelChangerIncrement()
                    case 1:
                        levelChangerIncrement()
                    case 2:
                        // This shows the youreReady image when the player completes the tutorial
                        let revealCutScene = SKAction.runBlock({
                            self.cutSceneTwo.hidden = false
                            let fadeIn = SKAction.fadeInWithDuration(0.5)
                            let wait = SKAction.waitForDuration(4)
                            let fadeOut = SKAction.fadeOutWithDuration(0.5)
                            let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
                            self.cutSceneTwo.runAction(sequence)
                            
                            
                        })
                        let waitChange = SKAction.waitForDuration(2)
                        let change = SKAction.runBlock({
                            self.levelChangerIncrement()
                        })
                        let sequence = SKAction.sequence([revealCutScene, waitChange, change])
                        runAction(sequence)
                    case 3:
                        let showCutSceneFour = SKAction.runBlock({
                            self.fadeInAndFadeOut(self.cutSceneFour)
                        })
                        let waitCutScene4 = SKAction.waitForDuration(3)
                        let changeLevelTo4 = SKAction.runBlock({
                            self.levelChangerIncrement()
                            completedLevel1 = true
                        })
                        let sequenceCutScene4 = SKAction.sequence([showCutSceneFour, waitCutScene4, changeLevelTo4])
                        runAction(sequenceCutScene4)
                        
                    case 4:
                        levelChangerIncrement()
                    case 5:
                        let revealCutSceneCase5 = SKAction.runBlock({
                           self.fadeInAndFadeOut(self.cutSceneSeven)
                        })
                        
                        let waitCase5 = SKAction.waitForDuration(2)
                        
                        let changeLevelCase5 = SKAction.runBlock({
                             self.levelChangerIncrement()
                        })
                       let sequenceCase5 = SKAction.sequence([revealCutSceneCase5, waitCase5, changeLevelCase5])
                       runAction(sequenceCase5)
                        
                    case 6:
                        levelChangerIncrement()
                        
                    case 7:
                        levelChangerIncrement()
                        
                    case 8:
                        levelChangerIncrement()
                        
                    case 9:
                        changeToTheEnd()
                        
                    default:
                        break
                    }
                    
                    
                }
                
            }
        
        // WHEN THE PINK CHARACTER MAKES CONTACT WIHT THE CHECKPOINT THIS HAPPENS
        case PhysicsCategory.PinkCharacter | PhysicsCategory.Checkpoint:
            // This goes to the LevelCompleteScene scene after making contact and the distance between the two objects is less than 60 pixels
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                if levelChanger <= 9 {
                    switch levelChanger {
                    case 0:
                        levelChangerIncrement()
                    case 1:
                        levelChangerIncrement()
                    case 2:
                        // This shows the youreReady image when the player completes the tutorial
                        let revealCutScene = SKAction.runBlock({
                            self.cutSceneTwo.hidden = false
                            let fadeIn = SKAction.fadeInWithDuration(0.5)
                            let wait = SKAction.waitForDuration(4)
                            let fadeOut = SKAction.fadeOutWithDuration(0.5)
                            let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
                            self.cutSceneTwo.runAction(sequence)
                            
                        })
                        let waitChange = SKAction.waitForDuration(2)
                        let change = SKAction.runBlock({
                            self.levelChangerIncrement()
                        })
                        let sequence = SKAction.sequence([revealCutScene, waitChange, change])
                        runAction(sequence)
                    case 3:
                        let showCutSceneFour = SKAction.runBlock({
                            self.cutSceneFour.hidden = false
                            let fadeIn = SKAction.fadeInWithDuration(0.5)
                            let wait = SKAction.waitForDuration(3)
                            let fadeOut = SKAction.fadeOutWithDuration(0.5)
                            let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
                            self.cutSceneFour.runAction(sequence)
                        })
                        let waitCutScene4 = SKAction.waitForDuration(3)
                        let changeLevelTo4 = SKAction.runBlock({
                            self.levelChangerIncrement()
                            completedLevel1 = true
                        })
                        let sequenceCutScene4 = SKAction.sequence([showCutSceneFour, waitCutScene4, changeLevelTo4])
                        runAction(sequenceCutScene4)
                        
                    case 4:
                        levelChangerIncrement()
                    case 5:
                        levelChangerIncrement()
                        fadeInAndFadeOut(cutSceneSeven)
                    case 6:
                        levelChangerIncrement()
                    case 7:
                        levelChangerIncrement()
                    case 8:
                        levelChangerIncrement()
                    case 9:
                        changeToTheEnd()
                        
                    default:
                        break
                    }
                    
                    
                }
                
            }
            
        // WHEN BOTH CHARACTERS MAKE CONTACT WITH EACH OTHER
        case PhysicsCategory.PinkCharacter | PhysicsCategory.BlueCharacter:
            twoBodiesMadeContact = true

            
        // WHEN PINK CHARACTER MAKES CONTACT WITH TRIGGER
        case PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger:
            switch levelChanger {
            case 0:
                // Contact between the characters and the Trigger in LevelChanger = 0
                triggerLvl0?.removeFromParent()
                
            case 2:
                // This reveals the instruction to not panic and connect
                // TODO: NO REPETITION
                connectInstruciton.hidden = false
                let fadeIn = SKAction.fadeInWithDuration(0.5)
                let wait = SKAction.waitForDuration(3)
                let fadeOut = SKAction.fadeOutWithDuration(0.5)
                let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
                connectInstruciton.runAction(sequence)
                
                blockade?.physicsBody?.affectedByGravity = true
                fallingPlatformLvl0?.physicsBody?.affectedByGravity = true
                fallingPlatformLvl0?.physicsBody?.dynamic = true
                
            case 7:
                // If this is at the IntroLvl 3, this should run when it makes contact with the trigger
                let waitFall = SKAction.waitForDuration(1)
                let fall = SKAction.moveToY(-20, duration: 0.2)
                let sequenceFall = SKAction.sequence([waitFall, fall])
                fallingPlatform?.runAction(sequenceFall)
                
                changeToGameOverScene()
                
            default:
                changeToGameOverScene()
            }
            
        // WHEN BLUECHARACTER MAKES CONTACT WITH AN OBJECT WITH CATEGORY OF .TRIGGER
        case PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger:
            switch levelChanger {
            case 0:
                // Contact between the characters and the Trigger in LevelChanger = 0
                triggerLvl0?.removeFromParent()
            case 2:
                // This reveals the instruction to not panic and connect
                connectInstruciton.hidden = false
                let fadeIn = SKAction.fadeInWithDuration(0.5)
                let wait = SKAction.waitForDuration(3)
                let fadeOut = SKAction.fadeOutWithDuration(0.5)
                let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
                connectInstruciton.runAction(sequence)
                
                blockade?.physicsBody?.affectedByGravity = true
                fallingPlatformLvl0?.physicsBody?.affectedByGravity = true
                fallingPlatformLvl0?.physicsBody?.dynamic = true
                
            case 7:
                // If this is at the IntroLvl 3, this should run when it makes contact with the trigger
                let waitFall = SKAction.waitForDuration(1)
                let fall = SKAction.moveToY(-20, duration: 0.2)
                let sequenceFall = SKAction.sequence([waitFall, fall])
                fallingPlatform?.runAction(sequenceFall)
                
                changeToGameOverScene()
            default:
                changeToGameOverScene()
            }
            
        case PhysicsCategory.BlueCharacter | PhysicsCategory.TriggerSwitchIns:
            // Contact between the characters and the Trigger in LevelChanger = 0
            let fadeIn = SKAction.fadeInWithDuration(0.5)
            let wait = SKAction.waitForDuration(1)
            let fadeOut = SKAction.fadeOutWithDuration(0.5)
            let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
            switchInstruction.runAction(sequence)
            switchInstruction.hidden = false
            triggerSwitchLvl0?.removeFromParent()
            
        case PhysicsCategory.PinkCharacter | PhysicsCategory.TriggerSwitchIns:
            // Contact between the characters and the Trigger in LevelChanger = 0
            let fadeIn = SKAction.fadeInWithDuration(0.5)
            let wait = SKAction.waitForDuration(1)
            let fadeOut = SKAction.fadeOutWithDuration(0.5)
            let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
            switchInstruction.runAction(sequence)
            switchInstruction.hidden = false
            triggerSwitchLvl0?.removeFromParent()
            
        case PhysicsCategory.PinkCharacter | PhysicsCategory.FallingPlatform:
            platformFall = true
            
        case PhysicsCategory.BlueCharacter | PhysicsCategory.FallingPlatform:
            platformFall = true
            
        case PhysicsCategory.BlueCharacter | PhysicsCategory.TransPlatform:
            platformTranslate = true
            
        case PhysicsCategory.PinkCharacter | PhysicsCategory.TransPlatform:
            platformTranslate = true
            
        default:
            break
        }
    }
    
    ///////////////////////////////////////////////
    // When two objects are no longer in contact //
    ///////////////////////////////////////////////
    // WHEN OBJECTS ARE NO LONGER IN CONTACT
    func didEndContact(contact: SKPhysicsContact) {
        twoBodiesMadeContact = false
    }
    
    // MARK: - Touches event
    
    // Note: When the screen is tapped on, this code runs
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        // let cameraLocation = touch.locationInNode(characterCamera)
        
        if levelChanger == 0 {
            self.scene!.view!.paused = false
        }
    
        stickActive = true
    }
    
    // This is used for detecting when a player moves their finger on the screen
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInNode(base)
        switch levelChanger {
        case 0:
            // TOOD: MAKE SURE THIS ONLY RUNS ONCE
            // To remove moveInstruction from the scene
            moveInstruction?.removeAllActions()
            moveInstruction?.hidden = true
            moveInstruction?.removeFromParent()
            
            baseInstruction.hidden = true
            baseInstruction.removeAllActions()
            baseInstruction.removeFromParent()
            
            forwardAndJumpIns.hidden = true
            forwardAndJumpIns.removeFromParent()
            
            tapToJump?.hidden = true
            tapToJump?.removeFromParent()
            handInstruction.hidden = true
            handInstruction.removeFromParent()
            
            jumpingHand.hidden = true
            jumpingHand.removeAllActions()
            jumpingHand.removeFromParent()
            
        default:
            break
        }
      
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        // let cameraLocation = touch.locationInNode(characterCamera)
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
        
        stick.position = CGPoint(x: x, y: y)
        
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if stickActive == true {
            let move = SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 0.1)
            move.timingMode = .EaseOut
            stick.runAction(move)
        }
        xValue = 0
        yValue = 0
    }
    
    // MARK: - Update Method
    
    ////////////////////
    // UPDATE METHOD ///
    ////////////////////

    override func update(currentTime: CFTimeInterval) {
        
        switch buttonFunctioning {
        case true:
            characterCamera.position = blueCharacter.position
            switch stickActive {
            case true:
                switch levelChanger {
                case 3:
                    let vector = CGVector(dx: 50 * xValue, dy: 0)
                    blueCharacter.physicsBody?.applyForce(vector)
                case 7:
                    levelChanger7PlatformAnimation()
                    movePlayerDefault(blueCharacter)
                default:
                    movePlayerDefault(blueCharacter)
                   
                }
            default:
                break
                
            }
            
        case false:
            characterCamera.position = pinkCharacter.position
            switch stickActive {
            case true:
                switch levelChanger {
                case 3:
                    let vector = CGVector(dx: 50 * xValue, dy: 0)
                    pinkCharacter.physicsBody?.applyForce(vector)
                case 7:
                    levelChanger7PlatformAnimation()
                    movePlayerDefault(pinkCharacter)
                default:
                    movePlayerDefault(pinkCharacter)
                   
            }
            default:
               break
            }
            
        }
        
        // This prevents the camera from going beyond the frame
        characterCamera.position.x.clamp(92, 476)
        characterCamera.position.y.clamp(250, 52)
        
        // Calculates X the difference between the two characters
        distanceOfCharacterDifferenceX = blueCharacter.position.x - pinkCharacter.position.x
        
        // Calculates the Y difference between the two characters
        distanceOfCharacterDifferenceY = blueCharacter.position.y - pinkCharacter.position.y
        
        autoSeparate()
        fadeGreenIndicator()
        
        // TODO: Figure out how to change the body when the objects are close together. Try asynchronous operations.
        //checkpointIndicatorChange()
        
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
            pos.x += 1

            links = [SKSpriteNode]()
    
            for i in 0..<5 {
                let link = SKSpriteNode(imageNamed: "link")
                link.size = CGSize(width: 2, height: 2)
                link.physicsBody = SKPhysicsBody(circleOfRadius: 1)
                if alreadyHidden == true {
                    link.hidden = true
                }
                
                link.physicsBody?.linearDamping = 0.2
                
                link.physicsBody?.categoryBitMask = 0
                link.physicsBody?.collisionBitMask = 0
                
                addChild(link)
                link.position = pos
                pos.x += 2
                
                links.append(link)
            }
            
            for i in 0..<links.count {
                if i == 0 {
                    let pin = SKPhysicsJointPin.jointWithBodyA(characterBack.physicsBody!,
                                                               bodyB: links[i].physicsBody!,
                                                               anchor: characterBack.position)
                    physicsWorld.addJoint(pin)
                    pinJoints.append(pin)
                    
                } else {
                    var anchor = links[i].position
                    anchor.x -= 1
                    let pin = SKPhysicsJointPin.jointWithBodyA(links[i - 1].physicsBody!,
                                                               bodyB: links[i].physicsBody!,
                                                               anchor: anchor)
                    physicsWorld.addJoint(pin)
                    pinJoints.append(pin)
                }
            }
            
            let pin = SKPhysicsJointPin.jointWithBodyA(characterFront.physicsBody!,
                                                       bodyB: links.last!.physicsBody!,
                                                       anchor: characterFront.position)
            pinJoints.append(pin)
            physicsWorld.addJoint(pin)

        
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
            switch self.buttonFunctioning {
            case true:
                switch self.canJump {
                case true:
                    
                    self.canJump = false
                    
                    switch levelChanger {
                    case 3:
                        self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
                    default:
                        switch self.separationExecuted {
                        case false:
                            self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 250))
                        default:
                            self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 330))
                        }
                    }
                    
                    let reset = SKAction.runBlock({
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(0.5)
                    self.runAction(SKAction.sequence([wait, reset]))
                    
                default:
                    break
                }
                
            case false:
                switch self.canJump {
                case true:
                    
                    self.canJump = false
                    
                    switch levelChanger {
                    case 3:
                        self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
                    default:
                        switch self.separationExecuted {
                        case false:
                            self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 250))
                        default:
                            self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 330))
                        }
                    }
                    
                    let reset = SKAction.runBlock({
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(0.5)
                    self.runAction(SKAction.sequence([wait, reset]))
                    
                default:
                    break
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
                self.separateButton.texture = SKTexture(imageNamed: "separatePinkButton")
            } else if self.buttonFunctioning == false {
                // Switch to the blueCharacter
                self.buttonFunctioning = true
                // This is used to change the color of the buttons from pink to blue
                self.switchButton.texture = SKTexture(imageNamed: "blueSwitchButton")
                self.separateButton.texture = SKTexture(imageNamed: "separateBlueButton")
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
            scene!.scaleMode = GameScaleMode.AllScenes
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
                print(self.bloodshotShouldRun)
                
                // This disables damage in IntroLvl1 so that it doesn't intimidate the players
                if levelChanger == 0 || levelChanger == 1 {
                    self.healthShouldReduce = false
                } else if levelChanger > 0 && levelChanger != 1 {
                   self.healthShouldReduce = true
                }
                
            } else if self.separationExecuted == false && self.twoBodiesMadeContact == true && abs(self.distanceOfCharacterDifferenceX) <= 17  {
                // The use of this is so that the links do not spawn backwards because the two characters have a negative difference in distance to each other.
                    // If the pinkCharacter is behind the blueCharacter
                    self.addChain()
                    self.separationExecuted = true
                    self.restoreHealth()
                    self.healthShouldReduce = false
                    self.separateButton.removeAllActions()

                
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
            // If it's on IntroLvl1 or IntroLvl2 autoSeparate cannot happen
        } else if abs(distanceOfCharacterDifferenceX) > 130 || abs(distanceOfCharacterDifferenceY) > 100 {
            // If the characters are too far apart from each other, it will autoseparate
            self.removeSomeJoints()
            // SeparationExecuted is set to false because it will trigger the reduceHealth in the update method
            self.separationExecuted = false
            // This is set to true so that it triggers the bloodshot effect
            
            switch levelChanger {
            case 0:
                self.bloodshotShouldRun = false
                self.healthShouldReduce = false
            case 1:
                self.bloodshotShouldRun = false
                self.healthShouldReduce = false
            case 2:
                self.removeSomeJoints()
                // SeparationExecuted is set to false because it will trigger the reduceHealth in the update method
                self.separationExecuted = false
                // This is set to true so that it triggers the bloodshot effect
                
                if separationExecuted == false {
                    self.bloodshotShouldRun = true
                    self.healthShouldReduce = true
                    separationButtonFade()
                }
            case 3:
                self.bloodshotShouldRun = false
                self.healthShouldReduce = false
            default:
                if separationExecuted == false {
                    self.bloodshotShouldRun = true
                    self.healthShouldReduce = true
                    separationButtonFade()
                }
                warning.hidden = false
                let show = SKAction.fadeInWithDuration(0.5)
                let wait = SKAction.waitForDuration(1)
                let hide = SKAction.fadeOutWithDuration(0.5)
                let sequence = SKAction.sequence([show, wait, hide])
                warning.runAction(sequence)
            }
           
        }
        
    }
  

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    // If the character is losing health, this helps show this. It stops running when healthRestore ///
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    func bloodshotEffect() {
        self.bloodshot.hidden = false
        // let firstDisappear = SKAction.fadeOutWithDuration(0.1)
        let flashIn = SKAction.fadeInWithDuration(1)
        let flashOut = SKAction.fadeOutWithDuration(1)
        let sequence = SKAction.sequence([flashIn, flashOut])
        self.bloodshot.runAction(SKAction.repeatActionForever(sequence))
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
            SKAction.runBlock() {
                switch levelChanger {
                case 3:
                    level1DeathCount += 1
                    print(level1DeathCount)
                case 4:
                    level2DeathCount += 1
                    print(level2DeathCount)
                case 5:
                    level3DeathCount += 1
                    print(level3DeathCount)
                case 6:
                    level4DeathCount += 1
                    print(level4DeathCount)
                case 7:
                    level5DeathCount += 1
                    print(level5DeathCount)
                case 8:
                    level6DeathCount += 1
                    print(level6DeathCount)
                case 9:
                    level7DeathCount += 1
                    print(level7DeathCount)
                default:
                    break
                }
            },
            SKAction.waitForDuration(0.1),
            SKAction.runBlock() {
                //print("CHANGING SCENE")
                let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
                let scene = GameOverScene(size: self.view!.frame.size)
                scene.scaleMode = GameScaleMode.AllScenes
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    // This function removes three joints so that when the button is pressed, only these will be removed ///
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func removeSomeJoints() {
        if !locked {
            print("Sorry not pinned! pins already removed")
            return
        }
        
        locked = false
        
        for _ in 0 ..< pinJoints.count {
            physicsWorld.removeJoint(pinJoints.removeFirst())
        }
        
        for i in 0 ..< links.count {
            let link = links.removeFirst()
            link.removeFromParent()
        }
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
                scene.scaleMode = GameScaleMode.AllScenes
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
    
    ///////////////////////////////////////////////////////////////////////////
    // These methods sets up the buttons so that it will run certan actions ///
    ///////////////////////////////////////////////////////////////////////////
    
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
            let scene = MenuScene(size: self.view!.frame.size)
            scene.scaleMode = GameScaleMode.AllScenes
            self.view!.presentScene(scene, transition: reveal)
      }
    }
    
    func setupAnchorButton () {
        anchorButton.selectedHandler = {
            if self.alreadyAnchored == true {
                if self.buttonFunctioning == true {
                    self.blueCharacter.physicsBody?.pinned = false
                    //self.blueCharacter.physicsBody?.allowsRotation = true
                    self.alreadyAnchored = false
                    print(self.alreadyAnchored)
                } else {
                    self.pinkCharacter.physicsBody?.pinned = false
                    self.alreadyAnchored = false
                }
            } else if self.buttonFunctioning == false {
                if self.alreadyAnchored == false {
                    self.pinkCharacter.physicsBody?.pinned = true
                    self.alreadyAnchored = true
                    print(self.alreadyAnchored)
                }
            } else if self.buttonFunctioning {
                if self.alreadyAnchored == false {
                self.blueCharacter.physicsBody?.pinned = true
                //self.blueCharacter.physicsBody?.allowsRotation = false
                self.alreadyAnchored = true
                print(self.alreadyAnchored)
                }
            }
        }
    }
    

    /// This function increments the levelChanger by 1 and executes the changeScene method.
    func levelChangerIncrement() {
        levelChanger += 1
        self.changeScene()
    }
    
    /// This is the default move impulse to the character when the joystick is moved.
    func movePlayerDefault(sprite: SKSpriteNode) {
        switch separationExecuted {
        // This code shows that if the character is separated, the character will be weaker
        case false:
            let vector = CGVector(dx: 40 * xValue, dy: 0)
            sprite.physicsBody?.applyForce(vector)
            reduceHealthBar()
        case true:
            let vector = CGVector(dx: 200 * xValue, dy: 0)
            sprite.physicsBody?.applyForce(vector)
            restoreHealth()
        }
    }
    
    /// This function is specific to Level 7 where there is a moving platform
    func levelChanger7PlatformAnimation() {
        fallingPlatformFunction()
        platformTranslateFunc(platformOne, yPosition: 100)
        platformTranslateFunc(platformTwo, yPosition: 120)
        platformTranslateFunc(platformThree, yPosition: 140)
        platformTranslateFunc(platformFour, yPosition: 160)
    }
    
    /// Used to setup instructions so that we don't have to repeat code.
    func setupInstructions(instruction: SKSpriteNode, positionX: CGFloat, positionY: CGFloat, alpha: CGFloat, zPosition: CGFloat, width: CGFloat, height: CGFloat) {
        instruction.zPosition = zPosition
        instruction.size = CGSize(width: width, height: height)
        instruction.alpha = alpha
        instruction.position = CGPoint(x: positionX, y: positionY)
        instruction.hidden = true
        characterCamera.addChild(instruction)
    }
    
    /// This is the animation used to fade in and out the instructions.
    func fadeInAndFadeOut(cutScene: SKSpriteNode) {
        cutScene.hidden = false
        let fadeIn = SKAction.fadeInWithDuration(0.5)
        let wait = SKAction.waitForDuration(3)
        let fadeOut = SKAction.fadeOutWithDuration(0.5)
        let delete = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut, delete])
        cutScene.runAction(sequence)
    }
    
    /// This function adds chain regardless of the position of the characters
    func addChain() {
        
        if locked {
            print("Sorry already pinned! pins in place")
            return
        }
        
        // Save position of blueCharacter and pinkCharacter
        let characterBluePos = blueCharacter.position
        let characterPinkPos = pinkCharacter.position
        
        let flashing = SKAction.runBlock({
            let fadeIn = SKAction.fadeInWithDuration(0.2)
            let fadeOut = SKAction.fadeOutWithDuration(0.2)
            let sequence = SKAction.sequence([fadeIn, fadeOut])
            self.flash.runAction(sequence)
        })
        
        let creatingChain = SKAction.runBlock({
            self.blueCharacter.position.x = 60
            self.pinkCharacter.position.x = 50
            
            self.blueCharacter.position.y = 100
            self.pinkCharacter.position.y = 100
            
            self.createChain(characterBack: self.pinkCharacter, characterFront: self.blueCharacter)
            
        })
        
        let reposition = SKAction.runBlock({
            // Move blueCharacter to original position
            self.blueCharacter.position = characterBluePos
            // Move pinkCharacter to original position
            self.pinkCharacter.position = characterPinkPos
            
        })
        
        runAction(SKAction.sequence([flashing, creatingChain, reposition]))
        
        locked = true
    }
   
}
