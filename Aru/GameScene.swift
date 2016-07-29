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
let arrayOfLevels: Array = ["IntroLvl1", // 0
                            "IntroLvl2", // 1
                            "IntroLvl3", // 2
                            "Level1",    // 3
                            "Level2",    // 4
                            "Level3",    // 5
                            "Level4",    // 6
                            "Level5",    // 7
                            "Level7",    // 8
                            "Level8",    // 9
                            //"Level9",    // 10
                            /*"Level10"*/]   // 11
//////////////////////////////////////////////////////

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
    
    // Declaring the switchButton property
    var switchButton: MSButtonNode!
    var buttonFunctioning: Bool = true
    var jumpButton: MSButtonNode!
    var alreadyTapped: Bool = true
    
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
    
    // Creating moving platform
    var movingPlatform: SKSpriteNode!
    
    // Create camera
    var characterCamera = SKCameraNode()
    
    // Create character indicator 
    var indicator: SKSpriteNode!
    
    // Instructions
    var moveInstruction: SKSpriteNode?
    var tapToJump: SKSpriteNode?
    
    // Healthbar objects
    var healthBar = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 250, height: 20))
    var currentHealth: CGFloat = 100
    var maxHealth: CGFloat = 100
    var healthShouldReduce: Bool = false
    
    // Creating trigger object
    var trigger: SKSpriteNode?
    
    // Create a blockadge object that will be triggered by the trigger
    var blockade: SKSpriteNode?
    
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
    
    override func didMoveToView(view: SKView) {
        
        // Sets the physics world so that it can detect contact
        self.physicsWorld.contactDelegate = self
        
        ////////////////////////////
        /// Character attributes ///
        ////////////////////////////
        
        // From the Character class, the characters gets its position set and is added to the scene
        blueCharacter = Character(characterColor: .Blue)
        pinkCharacter = Character(characterColor: .Pink)
        if levelChanger == 0 || levelChanger == 1 {
            blueCharacter.position = CGPoint(x: 65, y: 125)
            pinkCharacter.position = CGPoint(x: 50, y: 125)
            // print("THIS IS WORKING")
        } else if levelChanger == 2 {
            blueCharacter.position = CGPoint(x: 65, y: 175)
            pinkCharacter.position = CGPoint(x: 50, y: 175)
            // print("THIS IS WORKING")
        } else if levelChanger == 3 {
            // This is Level 1
            blueCharacter.position = CGPoint(x: 520, y: 260)
            pinkCharacter.position = CGPoint(x: 50, y: 260)
            blueCharacter.physicsBody?.linearDamping = 1
            pinkCharacter.physicsBody?.linearDamping = 1
            // print("LEVEL CHANGER == 3")
        } else if levelChanger == 4 {
            // This is Level 2
            blueCharacter.position = CGPoint(x: 70, y: 175)
            pinkCharacter.position = CGPoint(x: 40, y: 175)
        } else if levelChanger == 5 {
            // This is Level 3
            blueCharacter.position = CGPoint(x: 50, y: 100)
            pinkCharacter.position = CGPoint(x: 30, y: 100)
        } else if levelChanger == 6 {
            // This is Level 4
            blueCharacter.position = CGPoint(x: 280, y: 274)
            pinkCharacter.position = CGPoint(x: 265, y: 274)
        } else if levelChanger == 7 {
            // This is Level 5 
            blueCharacter.position = CGPoint(x: 60, y: 260)
            pinkCharacter.position = CGPoint(x: 50, y: 260)
            movingPlatform = childNodeWithName("//movingPlatform") as! SKSpriteNode
            let platformMove = SKAction.runBlock({
                let moveLeft = SKAction.moveToX(100, duration: 4)
                let moveRight = SKAction.moveToX(192, duration: 4)
                let sequence = SKAction.sequence([moveLeft, moveRight])
                self.movingPlatform.runAction(SKAction.repeatActionForever(sequence))
            })
        } else if levelChanger == 8 {
            // This is Level 6 
            blueCharacter.position = CGPoint(x: 60, y: 300)
            pinkCharacter.position = CGPoint(x: 50, y: 300)
        } else if levelChanger == 0 {
            self.separateButton.state = .Inactive
        }
        
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
        bloodshot = childNodeWithName("//bloodshot") as! SKSpriteNode
        bloodshot.hidden = true
        bloodshot.zPosition = 100
        
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
        
        // Blockade drops when the character makes contact with the trigger
        blockade = childNodeWithName("//blockade") as? SKSpriteNode
        blockade?.physicsBody?.affectedByGravity = false
        blockade?.physicsBody?.allowsRotation = false
        
        ///////////////////////////
        /// Creating Health Bar ///
        ///////////////////////////
        healthBar.position = CGPoint(x: -270, y: 140)
        healthBar.zPosition = 4
        healthBar.anchorPoint.x = 0
        //print(healthBar.position)
        
        
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
        base.alpha = 0.1
        base.hidden = true
        
        stick = SKSpriteNode(imageNamed: "stick")
        stick.size = CGSize(width: 80, height: 80)
        base.addChild(stick)
        
        ////////////////////////////////////
        /// These are buttons properties ///
        ////////////////////////////////////
        
        // Creates the jump and switch button
        switchButton = MSButtonNode(imageNamed: "blueSwitchButton")
        switchButton.size = CGSize(width: switchButton.size.width / 7, height: switchButton.size.height / 7)
        switchButton.zPosition = 101
        switchButton.position.x = 110
        switchButton.position.y = -110
        
        jumpButton = MSButtonNode(imageNamed: "blueJumpButton")
        jumpButton.size = CGSize(width: jumpButton.size.width / 7, height: jumpButton.size.height / 7)
        jumpButton.position.x = 210
        jumpButton.position.y = -90
        jumpButton.zPosition = 101
        
        separateButton = MSButtonNode(imageNamed: "separateBlueButton")
        separateButton.size = CGSize(width: separateButton.size.width / 16, height: separateButton.size.height / 16)
        separateButton.zPosition = 101
        separateButton.position = CGPoint(x: 20, y: -110)
        
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
        
        ////////////////////
        /// Instructions ///
        ////////////////////
        // Move instruction 
        moveInstruction = childNodeWithName("//moveInstruction") as? SKSpriteNode
        moveInstruction?.zPosition = 200
        // TapToJump Instruction 
        tapToJump = childNodeWithName("//tapToJump") as? SKSpriteNode
        tapToJump?.zPosition = 200
        
        /////////////////////////
        /// Calling functions ///
        /////////////////////////
        
        // autoSeparate()
        // bloodshotEffect()
        
        activateJumpButton()
        activateSwitchButton()
        createChain(characterBack: pinkCharacter, characterFront: blueCharacter)
        activateSeparateButton()
    
       
        // Creating a physical boundary to the edge of the scene
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        physicsBody?.categoryBitMask = PhysicsCategory.Platform
        physicsBody?.collisionBitMask = 1
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //////////////////////////////////////////////////////////////////
        // This is the contact between the character and the checkpoint //
        //////////////////////////////////////////////////////////////////
        
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene after making contact and the distance between the two objects is less than 50 pixels
            // The < 60 or > - 60 helps assure that only if the distance of the two characters is less than 60 pixels away, the checkpoint will work
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                levelChanger += 1
                changeScene()
            }
            
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene scene after making contact and the distance between the two objects is less than 60 pixels
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                levelChanger += 1
                changeScene()
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
            // print("THIS IS RUNNING")
        } else if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger {
            blockade?.physicsBody?.affectedByGravity = true
            // print("THIS IS RUNNING")
        }
            /////////////////////////////////////////////////////////////////
            // These two initiates the gameOverScene when the player falls //
            /////////////////////////////////////////////////////////////////
            
            
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger {
            if levelChanger != 2 {
                changeToGameOverScene()
            }
            print("GAMEOVER")
        }
            
        if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger {
            if levelChanger != 2 {
                changeToGameOverScene()
            }
            print("GAMEOVER")
        }
        
    }
    
    ///////////////////////////////////////////////
    // when two objects are no longer in contact //
    ///////////////////////////////////////////////
    
    func didEndContact(contact: SKPhysicsContact) {
        twoBodiesMadeContact = false
        // print("NO LONGER IN CONTACT")
    }
    
    // Note: When the screen is tapped on, this code runs
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        let cameraLocation = touch.locationInNode(characterCamera)
        // if cameraLocation.x < 0 {
        base.alpha = 0.5
        base.hidden = false
        base.position = cameraLocation
        //}
    
        // If the other half of the screen is tapped, this will run
        if (CGRectContainsPoint(base.frame, cameraLocation)) {
            stickActive = true
        }
        
        // Makes the instruction disappear
        moveInstruction?.hidden = true
        tapToJump?.hidden = true
    }
    
    // This is used for detecting when a player moves their finger on the screen
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInNode(base)
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        let cameraLocation = touch.locationInNode(characterCamera)
        let moveValue: CGFloat = 30
        
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
        
        // if cameraLocation.x < 0 {
            stick.position = CGPoint(x: x, y: y)
        // }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if stickActive == true {
            let move = SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 0.1)
            move.timingMode = .EaseOut
            stick.runAction(move)
            base.hidden = true
        }
        xValue = 0
        yValue = 0
    }
    
    ////////////////////
    // UPDATE METHOD ///
    ////////////////////

    override func update(currentTime: CFTimeInterval) {
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
        if buttonFunctioning {
            characterCamera.position = blueCharacter.position
        } else if buttonFunctioning == false {
            characterCamera.position = pinkCharacter.position
        }
        // This prevents the camera from going beyond the frame
        characterCamera.position.x.clamp(85, 483)
        characterCamera.position.y.clamp(250, -80)
        
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
        
        if buttonFunctioning {
            // This is when the camera follows the blueCharacter
            indicator.position = CGPoint(x: blueCharacter.position.x, y: blueCharacter.position.y + 20)
            // print("Indicator:", indicator.position)
        } else {
            // This is when the camear folllows the pinkCharacter
            indicator.position = CGPoint(x: pinkCharacter.position.x, y: pinkCharacter.position.y + 20)
            // print("Indicator:", indicator.position)
        }
        
        autoSeparate()
        // print(healthShouldReduce)
        // print("Position of Bridge:",bridge?.position)
        
      }
    
    ///////////////////////////////////////////////////////

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
        for _ in 0..<9 {
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
                print("LINK HIDDEN == FALSE")
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
                anchorPosition.x -= 1
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
                    let wait = SKAction.waitForDuration(1)
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
                    let wait = SKAction.waitForDuration(0.8)
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
                self.jumpButton.texture = SKTexture(imageNamed: "pinkJumpButton")
                self.switchButton.texture = SKTexture(imageNamed: "pinkSwitchButton")
            } else if self.buttonFunctioning == false {
                // Switch to the blueCharacter
                self.buttonFunctioning = true
                // This is used to change the color of the buttons from pink to blue
                self.jumpButton.texture = SKTexture(imageNamed: "blueJumpButton")
                self.switchButton.texture = SKTexture(imageNamed: "blueSwitchButton")
            }
        }
    }
    
    ////////////////////////////////////////////////////////
    // This function changes scene when collision occurs ///
    ////////////////////////////////////////////////////////
    
    func changeScene() {
        // Check for max levels because the this will always increase
        let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 2)
        let scene = GameScene(fileNamed: arrayOfLevels[levelChanger])
        scene!.scaleMode = .AspectFill
        self.view?.presentScene(scene!, transition: reveal)
        // print(levelChanger)
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
                // This disables damage in IntroLvl1 so that it doesn't intimidate the players
                if levelChanger == 0 {
                    self.healthShouldReduce = false
                } else if levelChanger > 0 {
                   self.healthShouldReduce = true
                }
            } else if self.separationExecuted == false && self.twoBodiesMadeContact == true && self.distanceOfCharacterDifferenceX <= 17 && self.distanceOfCharacterDifferenceX >= -17 {
                // The use of this is so that the links do not spawn backwards because the two characters have a negative difference in distance to each other.
                // print("CODE GETS THIS FAR")
                // THE PROBLEM IS THAT X < 0 BUT Y > THAN 0
                if self.distanceOfCharacterDifferenceX < 0 {
                    // If the blueChracter is behind the pinkCharacter
                    self.createChain(characterBack: self.blueCharacter, characterFront: self.pinkCharacter)
                    self.separationExecuted = true
                    self.restoreHealth()
                    self.healthShouldReduce = false
                    
                    // print("CODE CREATES CHAIN 1")
                } else if self.distanceOfCharacterDifferenceX > 0 {
                    // If the pinkCharacter is behind the blueCharacter
                    self.createChain(characterBack: self.pinkCharacter, characterFront: self.blueCharacter)
                    self.separationExecuted = true
                    self.restoreHealth()
                    self.healthShouldReduce = false
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
        
        if levelChanger == 0 {
            
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
        }
        
        if separationExecuted == false && levelChanger != 3 {
            self.bloodshotShouldRun = true
            self.healthShouldReduce = true
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
                print("CHANGING SCENE")
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
}
