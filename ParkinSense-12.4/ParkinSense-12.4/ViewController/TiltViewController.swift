//
//  TiltViewController.swift
//  ParkinSense
//
//  Created by Hamlet Jiang Su on 2019-10-27.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import UIKit
import SpriteKit

class TiltViewController: UIViewController {
    
    var countdownScene: CountdownGameScene!
    
    /* Variables related to game UI */
    var gameCountdown: Int = 60
    var currentScore: Int = 0
    
    
    //MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeScoreUI: UIStackView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startInitialCountdown()
    }
    
    /**
     Initializes the first scene and displays it on the screen.

     - Returns: None.
    */
    func startInitialCountdown() {
        let skView = view as! SKView
        
        skView.showsFPS = true
        
        countdownScene = CountdownGameScene(size: skView.bounds.size, parent: self)
        countdownScene.scaleMode = .aspectFill
        countdownScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        setupCountdownScene()
        
        skView.presentScene(countdownScene)
    }

    /**
     Hides the main UI of the game containing the time and score during the countdown

     - Returns: None.
    */
    func setupCountdownScene() {
        timeScoreUI.isHidden = true
        timeLabel.text = String(gameCountdown)
        scoreLabel.text = String(currentScore)
    }

}

