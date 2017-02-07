//
//  GameViewController.swift
//  Aru
//
//  Created by Trevin Wisaksana on 6/26/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SpriteKit

/// Used to keep track and change the level by changing the index of the Level Array.
var levelNumber = 0

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = LoadingScene(size: view.frame.size)
        // Configure the view.
        let skView = self.view as! SKView
        // Used only when debugging and testing
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsDrawCount = false
        skView.showsPhysics = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFit

        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
