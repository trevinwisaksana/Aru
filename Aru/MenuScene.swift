//
//  MenuScene.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/28/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    // MARK: - List of Menu Buttons
    /// Playbutton is an MSButtonNode that when tapped, it will switch the game to the first level.
    var playButton: MSButtonNode!
    /// Level button is an MSButtonNode that when tapped, it will show the levelMenu where the players can select and see the different levels.
    var levelsButton: MSButtonNode!
    var levelMenu: SKSpriteNode!
    var exitLevelMenu: MSButtonNode!
    var leftButton: MSButtonNode!
    var rightButton: MSButtonNode!
    
    // MARK: - List of Level Buttons
    var level1Button: MSButtonNode!
    var level2Button: MSButtonNode!
    var level3Button: MSButtonNode!
    var level4Button: MSButtonNode!
    var level5Button: MSButtonNode!
    var level6Button: MSButtonNode!
    var level7Button: MSButtonNode!
    // TODO: Create a menu where this will be the parent of all the objects
    
    // MARK: - didMoveToView
    override func didMoveToView(view: SKView) {
        setupButtons()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // let touch = touches.first
        // let location = touch?.locationInNode(self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    /// This sets up all the buttons. This method is called in didMoveToView.
    func setupButtons() {
        ////////////////////////////
        // Play Button Properties //
        ////////////////////////////
        playButton = MSButtonNode(imageNamed: "playButton")
        playButton.zPosition = 10
        playButton.size = CGSize(width: playButton.size.width / 3, height: playButton.size.height / 3)
        playButton.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height / 2)
        addChild(playButton)
        setupPlayButton()
        playButton.state = .Active
        
        /////////////////////////////
        // Level Button Properties //
        /////////////////////////////
        levelsButton = MSButtonNode(imageNamed: "levelsButton")
        levelsButton.zPosition = 10
        levelsButton.size = CGSize(width: levelsButton.size.width / 4, height: levelsButton.size.height / 4)
        levelsButton.position = CGPoint(x: self.frame.width * 0.4, y: self.frame.height / 2)
        addChild(levelsButton)
        setupLevelButton()
        levelsButton.state = .Active
        
        ///////////////////////////
        // Level Menu Properties //
        ///////////////////////////
        levelMenu = SKSpriteNode(imageNamed: "levelMenu")
        levelMenu.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        levelMenu.size = CGSize(width: self.levelMenu.size.width / 3.5, height: self.levelMenu.size.height / 3.5)
        levelMenu.zPosition = 11
        levelMenu.alpha = 0
        levelMenu.hidden = true
        addChild(self.levelMenu)
        setupLevelButton()
        
        ///////////////////////////////////
        // Exit Level Buttons Properties //
        ///////////////////////////////////
        exitLevelMenu = MSButtonNode(imageNamed: "exitLevelButton")
        exitLevelMenu.position = CGPoint(x: 110, y: 95)
        exitLevelMenu.size = CGSize(width: self.exitLevelMenu.size.width / 3, height: self.exitLevelMenu.size.height / 3)
        exitLevelMenu.zPosition = 15
        levelMenu.addChild(exitLevelMenu)
        exitLevelMenu.state = .Active
        setupExitButton()
        
        /////////////////////////////////
        // Level One Button Properties //
        /////////////////////////////////
        level1Button = MSButtonNode(imageNamed: "level1Button")
        level1Button.position = CGPoint(x: 0, y: 0)
        level1Button.size = CGSize(width: self.level1Button.size.width / 3, height: self.level1Button.size.height / 3)
        level1Button.zPosition = 15
        levelMenu.addChild(level1Button)
        level1Button.state = .Active
        setupLevel1Button()
        
        /////////////////////////////////
        // Level Two Button Properties //
        /////////////////////////////////
        level2Button = MSButtonNode(imageNamed: "level2Button")
        level2Button.position = CGPoint(x: 0, y: 0)
        level2Button.size = CGSize(width: self.level1Button.size.width / 3, height: self.level1Button.size.height / 3)
        level2Button.zPosition = 15
        levelMenu.addChild(level2Button)
        level2Button.state = .Active
        setupLevel2Button()
        
        ///////////////////////////////////
        // Level Three Button Properties //
        ///////////////////////////////////
        level3Button = MSButtonNode(imageNamed: "level3Button")
        level3Button.position = CGPoint(x: 0, y: 0)
        level3Button.size = CGSize(width: self.level1Button.size.width / 3, height: self.level1Button.size.height / 3)
        level3Button.zPosition = 15
        levelMenu.addChild(level3Button)
        level3Button.state = .Active
        setupLevel3Button()
        
        //////////////////////////////////
        // Level Four Button Properties //
        //////////////////////////////////
        level4Button = MSButtonNode(imageNamed: "level4Button")
        level4Button.position = CGPoint(x: 0, y: 0)
        level4Button.size = CGSize(width: self.level1Button.size.width / 3, height: self.level1Button.size.height / 3)
        level4Button.zPosition = 15
        levelMenu.addChild(level4Button)
        level4Button.state = .Active
        setupLevel4Button()
        
        //////////////////////////////////
        // Level Five Button Properties //
        //////////////////////////////////
        level5Button = MSButtonNode(imageNamed: "level5Button")
        level5Button.position = CGPoint(x: 0, y: 0)
        level5Button.size = CGSize(width: self.level1Button.size.width / 3, height: self.level1Button.size.height / 3)
        level5Button.zPosition = 15
        levelMenu.addChild(level5Button)
        level5Button.state = .Active
        setupLevel5Button()
        
        ////////////////////////////
        // Left Button Properties //
        ////////////////////////////
        leftButton = MSButtonNode(imageNamed: "switchLeftButton")
        leftButton.position = CGPoint(x: frame.width * 0.8, y: frame.height / 2)
        leftButton.size = CGSize(width: self.leftButton.size.width / 3, height: self.leftButton.size.height / 3)
        leftButton.zPosition = 15
        levelMenu.addChild(leftButton)
        
        
    }
    
    
    /// This sets the playButton to do the actions listed here.
    func setupPlayButton() {
        playButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 0.5)
            let scene = GameScene(fileNamed: "IntroLvl1")
            scene?.scaleMode = .AspectFill
            self.view!.presentScene(scene!, transition: reveal)
        }
    }
    
    /// When the levelsButton is tapped, this button will show Level Menu, a list of Levels as MSButtonNode.
    func setupLevelButton() {
        levelsButton.selectedHandler = {
            self.levelMenu.hidden = false
            let fadeIn = SKAction.fadeInWithDuration(0.1)
            self.levelMenu.runAction(fadeIn)
            
        }
    }
    
    /// When setupExitButton it will set the scale of the levelMenu to 0 and makes it hidden
    func setupExitButton() {
        exitLevelMenu.selectedHandler = {
            let minimize = SKAction.fadeOutWithDuration(0.1) /*SKAction.scaleTo(0, duration: 0.1)*/
            let hidden = SKAction.runBlock({
                self.levelMenu.hidden = true
            })
            self.levelMenu.runAction(SKAction.sequence([minimize, hidden]))
        }
    }
    
    /// This sets up the Level 1 Button so that it runs the designated code,
    func setupLevel1Button() {
        // if levelStar > 0 {
        //      nameOfButton.state = .Active
        // } else {
        //      nameOfButton.state = .False
        // }
        level1Button.selectedHandler = {
            // TODO: Create a NSUserDefault so that the players do not have to restart the game when they've played the level or not 
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 3
            if let scene = GameScene(fileNamed: arrayOfLevels[3]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 2 Button so that it runs the designated code.
    func setupLevel2Button() {
        level2Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 4
            if let scene = GameScene(fileNamed: arrayOfLevels[4]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 3 Button so that it runs the designated code.
    func setupLevel3Button() {
        level2Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 5
            if let scene = GameScene(fileNamed: arrayOfLevels[5]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 4 Button so that it runs the designated code.
    func setupLevel4Button() {
        level2Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 6
            if let scene = GameScene(fileNamed: arrayOfLevels[6]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 5 Button so that it runs the designated code.
    func setupLevel5Button() {
        level2Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 7
            if let scene = GameScene(fileNamed: arrayOfLevels[7]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 6 Button so that it runs the designated code.
    func setupLevel6Button() {
        level2Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 8
            if let scene = GameScene(fileNamed: arrayOfLevels[8]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 7 Button so that it runs the designated code.
    func setupLevel7Button() {
        level2Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 9
            if let scene = GameScene(fileNamed: arrayOfLevels[9]) {
                scene.scaleMode = .AspectFill
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the leftbutton so that it could switch between the level option on the list
    func setupLeftButton() {
        leftButton.selectedHandler = {
            
        }
    }
}
