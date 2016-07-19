//
//  GameScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//  In GameScene, only place the Gaming properties and attributes. Place different chapters in different scenes or different states as a state machine is set up.

import SpriteKit
import GameplayKit

// The directions is used for the joystick
enum Direction {
    case Left, Right, None
}

// These are the physics categories which must be set to allow collisions and contacts between objects
struct PhysicsCategory {
    static let None: UInt32             = 0         // 00000
    static let BlueCharacter: UInt32    = 0b1       // 00001
    static let PinkCharacter: UInt32    = 0b10      // 00010
    static let Checkpoint: UInt32       = 0b100     // 00100
    static let Platform: UInt32         = 0b1000    // 01000
    static let Edge: UInt32             = 0b10000   // 10000
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
    var blueCharacter: Character2!
    var pinkCharacter: Character2!
    
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
//    var checkpoint = SKSpriteNode(imageNamed: "checkpoint")
//    var target: Checkpoint!
    
    // Levels variables
    var level1: SKNode!
    var level2: SKNode!
    var level3: SKNode!
    
    override func didMoveToView(view: SKView) {
        
        // Sets the physics world so that it can detect contact
        self.physicsWorld.contactDelegate = self
        
        // From the Character class, the characters gets its position set and is added to the scene
        blueCharacter = Character2(characterColor: .Blue)
        pinkCharacter = Character2(characterColor: .Pink)
        blueCharacter.position = CGPoint(x: 70, y: 125)
        pinkCharacter.position = CGPoint(x: 50, y: 125)
        addChild(blueCharacter)
        addChild(pinkCharacter)
        
        // Referencing base to connect to the scene
        base = childNodeWithName("//base") as! SKSpriteNode
        
        // Referencing joystick to connect to the scene
        joystick = childNodeWithName("//joystick") as! SKSpriteNode
        
        // Referencing the switchButton node to the scene
        switchButton = self.childNodeWithName("switchButton") as! MSButtonNode
        jumpButton = self.childNodeWithName("jumpButton") as! MSButtonNode
      
        // Experimenting with code
        changeLevel("IntroLvl1", Type: "sks")
        
    
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
  
    
    // This function is designed to change the level of the game
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
             
        if collision == PhysicsCategory.BlueCharacter | PhysicsCategory.Checkpoint {
            // This goes to the LevelCompleteScene after making contact
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 2)
            let scene = LevelCompleteScene(size: self.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: reveal)
            print("CONTACT BEGINS")
        } else if collision == PhysicsCategory.PinkCharacter | PhysicsCategory.Checkpoint {
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
