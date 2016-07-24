//
//  GameScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//  In GameScene, only place the Gaming properties and attributes. Place different levels in different scenes or different states as a state machine is set up.


import SpriteKit

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
                            "Level9",    // 10
                            "Level10"]   // 11

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
    
    // Create camera
    var characterCamera = SKCameraNode()
    
    // Move instruction 
    var moveInstruction: SKSpriteNode?
    
    // Healthbar objects
    var healthBar = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 250, height: 20))
    var currentHealth: CGFloat = 100
    var maxHealth: CGFloat = 100
    
    // Creating trigger object
    var trigger: SKSpriteNode?
    
    // Create a blockadge object that will be triggered by the trigger
    var blockade: SKSpriteNode?
    
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
        } else {
            // TEMPORARY POSITION: SOON TO BE EDITTED
            blueCharacter.position = CGPoint(x: 65, y: 125)
            pinkCharacter.position = CGPoint(x: 50, y: 125)
        }
        
        addChild(blueCharacter)
        addChild(pinkCharacter)
        
        ///////////////////////////
        /// Creating Checkpoint ///
        ///////////////////////////
        
        // From the Checkpoint class, the checkpoint gets its position set and is added to the scene
        target = childNodeWithName("//checkpoint") as! Checkpoint
        target.setup()
        
        ////////////////////////
        /// Creating Trigger ///
        ////////////////////////
        
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
        print(healthBar.position)
        
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
        switchButton.state = .Active
        separateButton.state = .Active
        jumpButton.state = .Active
        
        // Adding the camera as the button's parent so that it follows its position
        characterCamera.addChild(switchButton)
        characterCamera.addChild(jumpButton)
        characterCamera.addChild(base)
        characterCamera.addChild(separateButton)
        characterCamera.addChild(healthBar)
        
        
        /////////////////////////
        /// Camera attributes ///
        /////////////////////////
        
        // Assuring that the target of the camera is the character's position
        addChild(characterCamera)
        self.camera = characterCamera
        characterCamera.xScale = 0.4
        characterCamera.yScale = 0.4
        
        // Move instruction 
        moveInstruction = childNodeWithName("//moveInstruction") as? SKSpriteNode
        moveInstruction?.zPosition = 200
        
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
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene after making contact and the distance between the two objects is less than 50 pixels
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                levelChanger += 1
                changeScene()
            }
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene scene after making contact and the distance between the two objects is less than 50 pixels
            if distanceOfCharacterDifferenceX < 60 && distanceOfCharacterDifferenceX > -60 && separationExecuted == true {
                levelChanger += 1
                changeScene()
            }
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.BlueCharacter {
            twoBodiesMadeContact = true
            // print("DID BEGIN CONTACT")
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Trigger {
            blockade?.physicsBody?.affectedByGravity = true
            print("THIS IS RUNNING")
        } else if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Trigger {
            blockade?.physicsBody?.affectedByGravity = true
            print("THIS IS RUNNING")
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        twoBodiesMadeContact = false
        // print("NO LONGER IN CONTACT")
    }
    
    // Note: When the screen is tapped on, this code runs
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        let cameraLocation = touch.locationInNode(characterCamera)
        if cameraLocation.x < 0 {
            base.alpha = 0.5
            base.hidden = false
            base.position = cameraLocation
        }
        
        // MARK: To do: Fix the two touches problem
        // The problem is that there are two touches began. This means that two different touches will run the touchesBegan twice!
        // touches.count == 2 needs two fingers on the screen at the same time which is not correct
    
        // If the other half of the screen is tapped, this will run
        if (CGRectContainsPoint(base.frame, cameraLocation)) {
            stickActive = true
        }
        
        // Makes the instruction disappear
        moveInstruction?.hidden = true
    }
    
    // This is used for detecting when a player moves their finger on the screen
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInNode(base)
        // The cameraLocation means that the touch will be relative to the characterCamera's position
        let cameraLocation = touch.locationInNode(characterCamera)
        
        // This is for the X axis
        var x = location.x
        if x > 30 {
            x = 30
        } else if x < -30 {
            x = -30
        }
        
        // This is for the Y axis
        var y = location.y
        if y > 30 {
            y = 30
        } else if y < -30 {
            y = -30
        }
        xValue = x / 30
        yValue = y / 30
        
        if cameraLocation.x < 0 {
            stick.position = CGPoint(x: x, y: y)
        }
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

    override func update(currentTime: CFTimeInterval) {
        // Called before each frame is rendered
        if buttonFunctioning == true {
            if stickActive == true {
                let vector = CGVector(dx: 400 * xValue, dy: 0)
                blueCharacter.physicsBody?.applyForce(vector)
            }
        } else {
            if stickActive == true {
                let vector = CGVector(dx: 400 * xValue, dy: 0)
                pinkCharacter.physicsBody?.applyForce(vector)
            }
        }
        if buttonFunctioning {
            characterCamera.position = blueCharacter.position
        } else if buttonFunctioning == false {
            characterCamera.position = pinkCharacter.position
        }
        // This prevents the camera from going beyond the frame
        characterCamera.position.x.clamp(115, 455)
        
        // Calculates X the difference between the two characters
        distanceOfCharacterDifferenceX = blueCharacter.position.x - pinkCharacter.position.x
        // print("x", distanceOfCharacterDifferenceX)
        
        // Calculates the Y difference between the two characters
        distanceOfCharacterDifferenceY = blueCharacter.position.y - pinkCharacter.position.y
        // print("y", distanceOfCharacterDifferenceY)
        
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
        pos.x += ((characterBack.position.x - characterFront.position.x) / 23) * 2.875 // 2
        pos.y -= ((characterBack.position.y - characterFront.position.y) / 23) * 2.875
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
            
            addChild(link)
            
            link.position = pos
            pos.x -= ((characterBack.position.x - characterFront.position.x) / 23) * 2.875 // 2
            // This assures that regardless of the Y position of the two characters, the link would be targeted to the center of the character
            pos.y -= ((characterBack.position.y - characterFront.position.y) / 23) * 2.875
            links.append(link)
        }
        
        for i in 0..<links.count {
            if i == 0 {
                // This pins the joint to the pinkCharacter
                let pin = SKPhysicsJointPin.jointWithBodyA(characterBack.physicsBody!,bodyB: links.first!.physicsBody!, anchor: characterBack.position)
               
                self.physicsWorld.addJoint(pin)
                
            } else {
                var anchorPosition = links[i].position
                anchorPosition.x -= 1
                // anchorPosition.y += characterBack.position.y - characterFront.position.y
                let pin = SKPhysicsJointPin.jointWithBodyA(links[i - 1].physicsBody!,bodyB: links[i].physicsBody!, anchor: anchorPosition)
             
                self.physicsWorld.addJoint(pin)
            }
            
            // This pins the joint to the blueCharacter
            let pin = SKPhysicsJointPin.jointWithBodyA(characterFront.physicsBody!, bodyB: links.last!.physicsBody!, anchor: characterFront.position)
            self.physicsWorld.addJoint(pin)
           
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
                    self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 405))
                    let reset = SKAction.runBlock({
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(1)
                    self.runAction(SKAction.sequence([wait, reset]))
                }
            } else if self.buttonFunctioning == false {
                if self.canJump {
                    self.canJump = false
                    self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 405))
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
            // print("DIFFERENCE X:", self.distanceOfCharacterDifferenceX)
            // print("DIFFERENCE Y:", self.distanceOfCharacterDifferenceY)
            if self.separationExecuted {
                self.physicsWorld.removeAllJoints()
                self.separationExecuted = false
                self.reduceHealthBar()
            } else if self.separationExecuted == false && self.twoBodiesMadeContact == true && self.distanceOfCharacterDifferenceX <= 23 && self.distanceOfCharacterDifferenceX >= -23 {
                // The use of this is so that the links do not spawn backwards because the two characters have a negative difference in distance to each other.
                // print("CODE GETS THIS FAR")
                // THE PROBLEM IS THAT X < 0 BUT Y > THAN 0
                if self.distanceOfCharacterDifferenceX < 0 {
                    // If the blueChracter is behind the pinkCharacter
                    self.createChain(characterBack: self.blueCharacter, characterFront: self.pinkCharacter)
                    self.separationExecuted = true
                    // print("CODE CREATES CHAIN 1")
                    
                } else if self.distanceOfCharacterDifferenceX > 0 {
                    // If the pinkCharacter is behind the blueCharacter
                    self.createChain(characterBack: self.pinkCharacter, characterFront: self.blueCharacter)
                    self.separationExecuted = true
                    // print("CODE CREATES CHAIN 2")
                    
                }
            }
        }
    }
    
    ///////////////////////////////////
    // Function to reduce healthBar ///
    ///////////////////////////////////
    
    func reduceHealthBar() {
        if currentHealth > 0 {
            currentHealth -= 25
            let healthBarReduce = SKAction.scaleXTo(currentHealth / maxHealth, duration: 0.5)
            healthBar.runAction(healthBarReduce)
        } else if currentHealth == 0 {
            
            currentHealth = 0
            runAction(SKAction.sequence([
                SKAction.waitForDuration(0),
                SKAction.runBlock() {
                    // 5
                    let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
                    let scene = GameOverScene(size: self.size)
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition:reveal)
                }
                ]))
        }
    }
}
