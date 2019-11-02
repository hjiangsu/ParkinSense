//
//  CountdownGameScene.swift
//  ParkinSense
//
//  Created by Hamlet Jiang Su on 2019-10-27.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import SpriteKit

class CountdownGameScene: SKScene {
    
    var countdownLabel: SKLabelNode = SKLabelNode()
    var count: Int = 5
    
    var viewController: TiltViewController
    
    init(size: CGSize, parent: TiltViewController) {
        self.viewController = parent
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        countdown()
    }
    
    
    /**
     Sets up countdown and displays countdown on the screen.

     - Returns: None.
    */
    func countdown() {
        countdownLabel.fontColor = SKColor.white
        countdownLabel.fontSize = 90
        countdownLabel.text = String(count)
        
        addChild(countdownLabel)
        
        let counterDecrement = SKAction.sequence([SKAction.wait(forDuration: 1.0),
                                                  SKAction.run(countdownAction)])
        
        run(SKAction.sequence([SKAction.repeat(counterDecrement, count: count),
                               SKAction.run(endCountdown)]))
    }
    
    
    /**
     Decrements the countdown by 1 and updates label.

     - Returns: None.
    */
    func countdownAction(){
        count -= 1
        countdownLabel.text = String(count)
    }
    
    
    /**
     Ends the countdown by removing the countdown from the screen. Starts transition to main game.

     - Returns: None.
    */
    func endCountdown() {
        countdownLabel.removeFromParent()
        transitionToGame()
    }
    
    /**
     Performs transition to a new scene for the main game.
     
     - TODO: Check to see which game we want to transition to - Tilt/Bubble Pop
     
     - Returns: None.
    */
    func transitionToGame() {
        let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
        let scene:SKScene = TiltGameScene(size: (self.view?.bounds.size)!, parent: self.viewController)
        self.view?.presentScene(scene, transition: transition)
    }
}
