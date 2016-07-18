//
//  GameScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//  In GameScene, only place the Gaming properties and attributes. Place different chapters in different scenes or different states as a state machine is set up.

import SpriteKit
import GameplayKit

enum Direction {
    case Left, Right, None
}

struct PhysicsCategory {
    static let None: UInt32             = 0         // 00000
    static let blueCharacter: UInt32    = 0b1       // 00001
    static let pinkCharacter: UInt32    = 0b10      // 00010
    static let checkpoint: UInt32       = 0b100     // 00100
    static let Platform: UInt32         = 0b1000    // 01000
    static let Edge: UInt32             = 0b10000   // 10000
    
    // 000000000000000000000000000000000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // These are the states for the state machine
    var gameSceneState: GKStateMachine!
    var playingState: GKState!
    var restartState: GKState!
    var gameOverState: GKState!
    var levelCompleteState: GKState!
    
    // This is the IntroLvl1 reference 
    var IntroLvl1: SKReferenceNode!
    
    // This is the direction property
    var direction: Direction = .None
    
    // This is the background property
    var background: SKNode!
    
    // Declaring base property
    var base: SKSpriteNode!
    // Delcaring joystick property
    var joystick: SKSpriteNode!
    
    // Declaring stick active property
    var stickActive: Bool! = false
    
    // Declaring character property
    var blueCharacter = SKSpriteNode(imageNamed: "blueBall")
    var pinkCharacter = SKSpriteNode(imageNamed: "pinkBall")
    
    // Declaring camera property
    var theCamera: SKCameraNode!
    
    // Declaring the switchButton property
    var switchButton: MSButtonNode!
    var buttonFunctioning: Bool = true
    var jumpButton: MSButtonNode!
    var alreadyTapped: Bool = true
    
    // Allows the button to be pressed once every 0.25 seconds
    var canJump = true
    
    // Array to contain the links of the joints 
    var links: [SKSpriteNode]!
    
    // Creating the checkpoint object
    var checkpoint = SKSpriteNode(imageNamed: "checkpoint")
    
    // Levels variables 
    var level1: SKNode!
    var level2: SKNode!
    var level3: SKNode!
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Making states objects with state classes
        restartState = RestartState(scene: self)
        playingState = PlayingState(scene: self)
        gameOverState = GameOver(scene: self)
        levelCompleteState = LevelComplete(scene: self)
        gameSceneState = GKStateMachine(states: [playingState, restartState])
        gameSceneState.enterState(PlayingState)

        // Referencing base to connect to the scene
        base = childNodeWithName("//base") as! SKSpriteNode
        
        // Referencing joystick to connect to the scene
        joystick = childNodeWithName("//joystick") as! SKSpriteNode
        
        // Referencing character to connect to the scene
        blueCharacter.physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        blueCharacter.position = CGPoint(x: 70, y: 125)
        blueCharacter.physicsBody?.mass = 1
        blueCharacter.size = CGSize(width: 23, height: 23)
        blueCharacter.physicsBody?.affectedByGravity = true
        blueCharacter.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueCharacter.physicsBody?.categoryBitMask = PhysicsCategory.blueCharacter
        blueCharacter.physicsBody?.collisionBitMask = PhysicsCategory.pinkCharacter | PhysicsCategory.Platform | PhysicsCategory.Edge | PhysicsCategory.blueCharacter
        /*This is so that it collides with the platform*/
        blueCharacter.physicsBody?.contactTestBitMask = PhysicsCategory.checkpoint
        self.addChild(blueCharacter)
        //
        pinkCharacter.position = CGPoint(x: 50, y: 125)
        pinkCharacter.size = CGSize(width: 23, height: 23)
        // Declaration of physicsBody must be placed on top before setting the rest of the physics roperties
        pinkCharacter.physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        pinkCharacter.physicsBody!.mass = 1
        pinkCharacter.physicsBody!.affectedByGravity = true
        pinkCharacter.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pinkCharacter.physicsBody!.categoryBitMask = PhysicsCategory.pinkCharacter
        pinkCharacter.physicsBody?.collisionBitMask = PhysicsCategory.blueCharacter | PhysicsCategory.Platform
        pinkCharacter.physicsBody?.contactTestBitMask = PhysicsCategory.checkpoint
        self.addChild(pinkCharacter)
        //
        
        // Referencing the switchButton node to the scene
        switchButton = self.childNodeWithName("switchButton") as! MSButtonNode
        jumpButton = self.childNodeWithName("jumpButton") as! MSButtonNode
      
        // Referencing theCamera to connect to the scene
        theCamera = childNodeWithName("//cameraTarget") as! SKCameraNode
        
        // Referencing checkpoint object
        checkpoint.physicsBody = SKPhysicsBody(circleOfRadius: 11.5)
        checkpoint.position = CGPoint(x: 522, y: 185)
        checkpoint.physicsBody?.affectedByGravity = false
        checkpoint.zPosition = 10
        checkpoint.physicsBody?.categoryBitMask = PhysicsCategory.checkpoint
        checkpoint.physicsBody?.collisionBitMask = PhysicsCategory.None
        checkpoint.physicsBody?.contactTestBitMask = PhysicsCategory.blueCharacter | PhysicsCategory.pinkCharacter
        addChild(checkpoint)
        
        // Experimenting with code
        changeLevel("IntroLvl1", Type: "sks")
        //
    
        //////////////////////////////////////////////////////
        
        // Switch button allows the player to switch between characters
        switchButton.selectedHandler = {
            if self.buttonFunctioning {
                self.buttonFunctioning = false
            } else if self.buttonFunctioning == false {
                self.buttonFunctioning = true
            }
        }
        
        // Jump button allows the character to jump
        jumpButton.selectedHandler = {
            if self.buttonFunctioning {
                if self.canJump {
                    self.canJump = false
                    self.blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 403))
                    
                    let reset = SKAction.runBlock({ 
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(1)
                    self.runAction(SKAction.sequence([wait, reset]))
                }
                
            } else if self.buttonFunctioning == false {
                if self.canJump {
                    self.canJump = false
                    self.pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 403))
                    let reset = SKAction.runBlock({
                        self.canJump = true
                    })
                    let wait = SKAction.waitForDuration(0.8)
                    self.runAction(SKAction.sequence([wait, reset]))
                }
            }
        }
        // Creating a physical boundary to the edge of the scene
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        physicsBody?.categoryBitMask = PhysicsCategory.Platform
        physicsBody?.collisionBitMask = 1
       
      createChain()
        
    }
    
    ////////////////////
    // Inside here are functions
    func createChain() {
        var positionOne = self.pinkCharacter.position
        links = [SKSpriteNode]()
        
        for i in 0..<10 {
            let link = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 2, height: 2))
            link.physicsBody = SKPhysicsBody(rectangleOfSize: link.size)
            link.position = pinkCharacter.position
            link.zPosition = 2
            
            link.physicsBody?.categoryBitMask = 0
            link.physicsBody?.collisionBitMask = 0
            link.physicsBody?.contactTestBitMask = 1
            
            addChild(link)
            // Distance between each chain
            positionOne.x += 2
            link.position = positionOne
            links.append(link)
        }
        
        for i in 0..<links.count {
            if i == 0 {
                let pin = SKPhysicsJointPin.jointWithBodyA(pinkCharacter.physicsBody!,bodyB: links[i].physicsBody!, anchor: self.pinkCharacter.position)
                physicsWorld.addJoint(pin)
            } else {
                var anchor = links[i].position
                anchor.x -= 0
                let pin = SKPhysicsJointPin.jointWithBodyA(links[i - 1].physicsBody!,bodyB: links[i].physicsBody!, anchor: anchor)
                self.physicsWorld.addJoint(pin)
            }
        }
        let pin = SKPhysicsJointPin.jointWithBodyA(blueCharacter.physicsBody!, bodyB: links.last!.physicsBody!, anchor: blueCharacter.position)
        self.physicsWorld.addJoint(pin)
    }
    ////////////////////
    
    // This funciton is designed to change the level of the game
    func changeLevel(Name: String, Type: String) {
        let changeScene = SKAction.runBlock({
            let path = NSBundle.mainBundle().pathForResource(Name, ofType: Type)
            let node = SKReferenceNode (URL: NSURL (fileURLWithPath: path!))
            self.addChild(node)
        })
        self.runAction(changeScene)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.blueCharacter | PhysicsCategory.checkpoint {
            // This goes to the LevelCompleteScene after making contact
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 2)
            let scene = LevelCompleteScene(size: self.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: reveal)
            print("CONTACT BEGINS")
        } else if collision == PhysicsCategory.pinkCharacter | PhysicsCategory.checkpoint {
            // This goes to the LevelCompleteScene scene after making contact
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 2)
            let scene = LevelCompleteScene(size: self.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: reveal)
            print("CONTACT BEGINS")
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Make the base and joystick hidden
            if touches.count > 0 && location.x < size.width / 2 {
                base.hidden = false
                joystick.hidden = false
                let location = touch.locationInNode(self)
                joystick.position = location
                base.position = location
            } else {
                base.hidden = true 
                joystick.hidden  = true
            }
            
            if touches.count > 0 {
            }

            if (CGRectContainsPoint(base.frame, location)) {
                stickActive = true
            }
            
        }
        
    }
    
        // This is used for detecting when a player moves their finger on the screen
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if stickActive == true {
                // This tracks the difference in distance between the finger's position on the screen and the distance of the base
                let vector = CGVector(dx: location.x - base.position.x, dy: location.y - base.position.y)
                let angle = atan2(vector.dy, vector.dx)
                
                let length : CGFloat = base.frame.size.height / 2
                let xDistance : CGFloat = sin(angle - 1.57079633) * length
                let yDistance : CGFloat = cos(angle - 1.57079633) * length
                if(xDistance > 0){
                    direction = .Right
                }else if(xDistance < 0){
                    direction = .Left
                }

                if (CGRectContainsPoint(base.frame, location)) {
                    joystick.position = location
                } else {
                    joystick.position = CGPoint(x: base.position.x - xDistance, y: base.position.y + yDistance)
                    
                }
            
            }
                
        }
        
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if stickActive == true {
            direction = .None
            let move = SKAction.moveTo(base.position, duration: 0.1)
            move.timingMode = .EaseOut
            joystick.runAction(move)
        }
    }

    override func update(currentTime: CFTimeInterval) {
        // Called before each frame is rendered
        
        gameSceneState.updateWithDeltaTime(currentTime)
        
        if buttonFunctioning == true {
            if stickActive == true {
                switch direction {
                case .Left:
                    blueCharacter.physicsBody?.applyImpulse(CGVector(dx: 4, dy: 0))
                    //print(">>>>>>>>>>>>>")
                case .Right:
                    blueCharacter.physicsBody?.applyImpulse(CGVector(dx: -4, dy: 0))
                    //print("<<<<<<<<<<<<<")
                case .None:
                    print("")
                }
            }
        } else {
            if stickActive == true {
                switch direction {
                case .Left:
                    pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: 4, dy: 0))
                    //print(">>>>>>>>>>>>>")
                case .Right:
                    pinkCharacter.physicsBody?.applyImpulse(CGVector(dx: -4, dy: 0))
                    //print("<<<<<<<<<<<<<")
                case .None:
                    print("")
                }
            }
        }
      }

}
