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
    
    // MARK: - Level List Checker
    var levelListChecker: Int = 0
    
    // MARK: - didMoveToView
    override func didMoveToView(view: SKView) {
        setupButtons()
    }
    
    // MARK: - touchesBegan
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // let touch = touches.first
        // let location = touch?.locationInNode(self)
        
    }
    
    // MARK: - touchesMoved
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    // MARK: - update
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    // MARK: - Setup Buttons
    
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
        if completedLevel1 == true {
            level1Button.state = .Active
        }
        setupLevel1Button()
        
        /////////////////////////////////
        // Level Two Button Properties //
        /////////////////////////////////
        level2Button = MSButtonNode(imageNamed: "level2Button")
        level2Button.position = CGPoint(x: 0, y: 0)
        level2Button.size = CGSize(width: self.level2Button.size.width / 3, height: self.level2Button.size.height / 3)
        level2Button.zPosition = 15
        levelMenu.addChild(level2Button)
        level2Button.state = .Active
        level2Button.hidden = true
        level2Button.alpha = 0
        setupLevel2Button()
        
        ///////////////////////////////////
        // Level Three Button Properties //
        ///////////////////////////////////
        level3Button = MSButtonNode(imageNamed: "level3Button")
        level3Button.position = CGPoint(x: 0, y: 0)
        level3Button.size = CGSize(width: self.level3Button.size.width / 3, height: self.level3Button.size.height / 3)
        level3Button.zPosition = 15
        levelMenu.addChild(level3Button)
        level3Button.state = .Active
        level3Button.hidden = true
        level3Button.alpha = 0
        setupLevel3Button()
        
        //////////////////////////////////
        // Level Four Button Properties //
        //////////////////////////////////
        level4Button = MSButtonNode(imageNamed: "level4Button")
        level4Button.position = CGPoint(x: 0, y: 0)
        level4Button.size = CGSize(width: self.level4Button.size.width / 3, height: self.level4Button.size.height / 3)
        level4Button.zPosition = 15
        levelMenu.addChild(level4Button)
        level4Button.state = .Active
        level4Button.hidden = true
        level4Button.alpha = 0
        setupLevel4Button()
        
        //////////////////////////////////
        // Level Five Button Properties //
        //////////////////////////////////
        level5Button = MSButtonNode(imageNamed: "level5Button")
        level5Button.position = CGPoint(x: 0, y: 0)
        level5Button.size = CGSize(width: self.level5Button.size.width / 3, height: self.level5Button.size.height / 3)
        level5Button.zPosition = 15
        levelMenu.addChild(level5Button)
        level5Button.state = .Active
        level5Button.hidden = true
        level5Button.alpha = 0
        setupLevel5Button()
        
        /////////////////////////////////
        // Level Six Button Properties //
        /////////////////////////////////
        level6Button = MSButtonNode(imageNamed: "level6Button")
        level6Button.position = CGPoint(x: 0, y: 0)
        level6Button.size = CGSize(width: self.level6Button.size.width / 3, height: self.level6Button.size.height / 3)
        level6Button.zPosition = 15
        levelMenu.addChild(level6Button)
        level6Button.hidden = true
        level6Button.alpha = 0
        level6Button.state = .Active
        setupLevel6Button()
        
        ///////////////////////////////////
        // Level Seven Button Properties //
        ///////////////////////////////////
        level7Button = MSButtonNode(imageNamed: "level7Button")
        level7Button.position = CGPoint(x: 0, y: 0)
        level7Button.size = CGSize(width: self.level7Button.size.width / 3, height: self.level7Button.size.height / 3)
        level7Button.zPosition = 15
        levelMenu.addChild(level7Button)
        level7Button.hidden = true
        level7Button.alpha = 0
        level7Button.state = .Active
        setupLevel7Button()
        
        ////////////////////////////
        // Left Button Properties //
        ////////////////////////////
        leftButton = MSButtonNode(imageNamed: "switchLevelLeft")
        leftButton.position = CGPoint(x: -200, y: 0)
        leftButton.size = CGSize(width: self.leftButton.size.width / 10, height: self.leftButton.size.height / 10)
        leftButton.zPosition = 15
        levelMenu.addChild(leftButton)
        leftButton.state = .Active
        setupLeftButton()
        
        /////////////////////////////
        // Right Button Properties //
        /////////////////////////////
        rightButton = MSButtonNode(imageNamed: "switchLevelRight")
        rightButton.position = CGPoint(x: 200, y: 0)
        rightButton.size = CGSize(width: self.rightButton.size.width / 10, height: self.rightButton.size.height / 10)
        rightButton.zPosition = 15
        levelMenu.addChild(rightButton)
        rightButton.state = .Active
        setupRightButton()
        
    }
    
    ///////////////////////////////////////////////////////////////////
    // These methods sets up the actions when the buttons are tapped //
    ///////////////////////////////////////////////////////////////////
    
    /// This sets the playButton to do the actions listed here.
    func setupPlayButton() {
        playButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1)
            let scene = GameScene(fileNamed: "IntroLvl1")
            scene?.scaleMode = .AspectFit
            self.view!.presentScene(scene!, transition: reveal)
        }
    }
    
    /// When the levelsButton is tapped, this button will show Level Menu, a list of Levels as MSButtonNode.
    func setupLevelButton() {
        levelsButton.selectedHandler = {
            self.levelMenu.hidden = false
            let fadeIn = SKAction.fadeInWithDuration(0.2)
            self.levelMenu.runAction(fadeIn)
            
        }
    }
    
    /// When setupExitButton it will set the scale of the levelMenu to 0 and makes it hidden
    func setupExitButton() {
        exitLevelMenu.selectedHandler = {
            let minimize = SKAction.fadeOutWithDuration(0.2)
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
                scene.scaleMode = .AspectFit
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
                scene.scaleMode = .AspectFit
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 3 Button so that it runs the designated code.
    func setupLevel3Button() {
        level3Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 5
            if let scene = GameScene(fileNamed: arrayOfLevels[5]) {
                scene.scaleMode = .AspectFit
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 4 Button so that it runs the designated code.
    func setupLevel4Button() {
        level4Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 6
            if let scene = GameScene(fileNamed: arrayOfLevels[6]) {
                scene.scaleMode = .AspectFit
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 5 Button so that it runs the designated code.
    func setupLevel5Button() {
        level5Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 7
            if let scene = GameScene(fileNamed: arrayOfLevels[7]) {
                scene.scaleMode = .AspectFit
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 6 Button so that it runs the designated code.
    func setupLevel6Button() {
        level6Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 8
            if let scene = GameScene(fileNamed: arrayOfLevels[8]) {
                scene.scaleMode = .AspectFit
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the Level 7 Button so that it runs the designated code.
    func setupLevel7Button() {
        level7Button.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 0.5)
            levelChanger = 9
            if let scene = GameScene(fileNamed: arrayOfLevels[9]) {
                scene.scaleMode = .AspectFit
                self.view!.presentScene(scene, transition: reveal)
            } else {
                print("Could not load level")
            }
        }
    }
    
    /// This sets up the leftbutton so that it could switch between the level option on the list
    func setupLeftButton() {
        leftButton.selectedHandler = {
            
            if self.levelListChecker > 0 {
                self.levelListChecker -= 1
                print(self.levelListChecker)
            }
            self.levelSwitchButtonCase(oneAppear: self.level2Button,
                                       oneDisappear: self.level3Button,
                                       
                                       twoAppear: self.level3Button,
                                       twoDisappear: self.level4Button,
                                       
                                       threeAppear: self.level4Button,
                                       threeDisappear: self.level5Button,
                                       
                                       fourAppear: self.level5Button,
                                       fourDisappear: self.level6Button,
                                       
                                       fiveAppear: self.level6Button,
                                       fiveDisappear: self.level7Button,
                                       
                                       sixAppear: self.level6Button,
                                       sixDisappear: self.level7Button)
        
      }
    }
    
    /// This sets up the rightButton so that it could switch between the level option on the list
    func setupRightButton() {
        rightButton.selectedHandler = {
            
            if self.levelListChecker < 6 {
                self.levelListChecker += 1
                print(self.levelListChecker)
            }
            self.levelSwitchButtonCase(oneAppear: self.level2Button,
                                       oneDisappear: self.level1Button,
                                       
                                       twoAppear: self.level3Button,
                                       twoDisappear: self.level2Button,
                                       
                                       threeAppear: self.level4Button,
                                       threeDisappear: self.level3Button,
                                       
                                       fourAppear: self.level5Button,
                                       fourDisappear: self.level4Button,
                                       
                                       fiveAppear: self.level6Button,
                                       fiveDisappear: self.level5Button,
                                       
                                       sixAppear: self.level7Button,
                                       sixDisappear: self.level6Button)
        
        }
    }
    
    //////////////////////////////////////////////////////////////////
    // These methods sets up case of which button disappears or not //
    //////////////////////////////////////////////////////////////////
    
    func buttonDisappear(hide: MSButtonNode) {
        // The level1Button disappears
        let fadeOut = SKAction.fadeOutWithDuration(0.5)
        hide.runAction(fadeOut)
        hide.hidden = true
    }
    
    func buttonAppear(appear: MSButtonNode) {
        // The level2Button appears
        let fadeIn = SKAction.fadeInWithDuration(0.5)
        appear.runAction(fadeIn)
        appear.hidden = false
    }
    
    /// Sets which buttons to appear or disappear
    func levelSwitchButtonCase(oneAppear oneAppear: MSButtonNode, oneDisappear: MSButtonNode, twoAppear: MSButtonNode, twoDisappear: MSButtonNode, threeAppear: MSButtonNode, threeDisappear: MSButtonNode, fourAppear: MSButtonNode, fourDisappear: MSButtonNode, fiveAppear: MSButtonNode, fiveDisappear: MSButtonNode, sixAppear: MSButtonNode, sixDisappear: MSButtonNode) {
        switch self.levelListChecker {
        case 0:
            // Only level1Button appears
            buttonAppear(self.level1Button)
            
            buttonDisappear(self.level2Button)
            break
        case 1:
            // The level1Button disappears
            buttonDisappear(oneDisappear)
            
            // The level2Button appears
            buttonAppear(oneAppear)
        case 2:
            // The level2Button disappears
            buttonDisappear(twoDisappear)
            
            // The level3Button appears
            buttonAppear(twoAppear)
        case 3:
            // The level2Button disappears
            buttonDisappear(threeDisappear)
            
            // The level2Button appears
            buttonAppear(threeAppear)
        case 4:
            // The level2Button disappears
            buttonDisappear(fourDisappear)
            
            // The level2Button appears
            buttonAppear(fourAppear)
        case 5:
            // The level2Button disappears
            buttonDisappear(fiveDisappear)
            
            // The level2Button appears
            buttonAppear(fiveAppear)
        case 6:
            // The level2Button disappears
            buttonDisappear(sixDisappear)
        
            // The level2Button appears
            buttonAppear(sixAppear)
        default:
            break
        }
    }
}
