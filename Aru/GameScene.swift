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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // These are the states for the state machine
    var gameSceneState: GKStateMachine!
    var playingState: GKState!
    var restartState: GKState!
    var level1State: GKState!
    
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
    var characterTest: SKSpriteNode!
    var pinkCharacter: SKSpriteNode!
    
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
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        // Making states objects with state classes
        restartState = RestartState(scene: self)
        playingState = PlayingState(scene: self)

        // Referencing base to connect to the scene
        base = childNodeWithName("//base") as! SKSpriteNode
        // Referencing joystick to connect to the scene
        joystick = childNodeWithName("//joystick") as! SKSpriteNode
        
        // Referencing character to connect to the scene
        characterTest = childNodeWithName("//blueCharacter") as! SKSpriteNode
        characterTest.removeFromParent()
        self.addChild(characterTest)
        characterTest.position = CGPoint(x: 70, y: 125)
        pinkCharacter = childNodeWithName("//pinkCharacter") as! SKSpriteNode
        pinkCharacter.removeFromParent()
        self.addChild(pinkCharacter)
        pinkCharacter.position = CGPoint(x: 50, y: 125)
        // Referencing the switchButton node to the scene
        switchButton = self.childNodeWithName("switchButton") as! MSButtonNode
        jumpButton = self.childNodeWithName("jumpButton") as! MSButtonNode
      
        // Referencing theCamera to connect to the scene
        theCamera = childNodeWithName("//cameraTarget") as! SKCameraNode
    
        //////////////////////////////////////////////////////
        
        // Switch button allows the player to switch between characters
        switchButton.selectedHandler = {
            if self.buttonFunctioning {
                self.buttonFunctioning = false
                print(self.buttonFunctioning)
            } else if self.buttonFunctioning == false {
                self.buttonFunctioning = true
                print(self.buttonFunctioning)
            }
        }
        
        // Jump button allows the character to jump
        jumpButton.selectedHandler = {
            if self.buttonFunctioning {
                if self.canJump {
                    self.canJump = false
                    self.characterTest.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 403))
                    print("JUMP!!")
                    
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
                    print("JUMP!!")
                    
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
        physicsBody?.categoryBitMask = 1
        physicsBody?.collisionBitMask = 1
       
      createChain()
        
    }
    
    ////////////////////
    func createChain() {
        var positionOne = self.pinkCharacter.position
        links = [SKSpriteNode]()
        
        for i in 0..<8 {
            let link = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: 2, height: 2))
            link.physicsBody = SKPhysicsBody(rectangleOfSize: link.size)
            link.position = pinkCharacter.position
            
            link.physicsBody?.categoryBitMask = 0
            link.physicsBody?.collisionBitMask = 0
            link.physicsBody?.contactTestBitMask = 0
            
            addChild(link)
            print(self.pinkCharacter.position)
            positionOne.x += 2
            link.position = positionOne
            // Separates the distance of the links
            
            links.append(link)
        }
        
        for i in 0..<links.count {
            if i == 0 {
                let pin = SKPhysicsJointPin.jointWithBodyA(pinkCharacter.physicsBody!,bodyB: links[i].physicsBody!, anchor: self.pinkCharacter.position)
                physicsWorld.addJoint(pin)
            } else {
                // THIS IS NOT THE CAUSE
                var anchor = links[i].position
                anchor.x -= 2
                let pin = SKPhysicsJointPin.jointWithBodyA(links[i - 1].physicsBody!,bodyB: links[i].physicsBody!, anchor: anchor)
                self.physicsWorld.addJoint(pin)
            }
        }
        let pin = SKPhysicsJointPin.jointWithBodyA(characterTest.physicsBody!, bodyB: links.last!.physicsBody!, anchor: characterTest.position)
        self.physicsWorld.addJoint(pin)
    }
    ////////////////////
    
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
            print(touches.count)
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
                
                // let deg = angle * CGFloat(180 / M_PI)
                
                let length : CGFloat = base.frame.size.height / 2
                let xDistance : CGFloat = sin(angle - 1.57079633) * length
                let yDistance : CGFloat = cos(angle - 1.57079633) * length
                if(xDistance > 0){
                    direction = .Right
                }else if(xDistance < 0){
                    direction = .Left
                }
                print("Direction: \(direction) xDistance: \(xDistance)")
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
                    characterTest.physicsBody?.applyImpulse(CGVector(dx: 4, dy: 0))
                    //print(">>>>>>>>>>>>>")
                case .Right:
                    characterTest.physicsBody?.applyImpulse(CGVector(dx: -4, dy: 0))
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

    func didBeginContact(contact: SKPhysicsContact) {
        
    }

}
