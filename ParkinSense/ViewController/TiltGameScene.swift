//
//  TiltGameScene.swift
//  ParkinSense
//
//  Created by Hamlet Jiang Su on 2019-10-27.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import SpriteKit
import CoreMotion

class TiltGameScene: SKScene {
    
    let viewController: TiltViewController
    let motionManager = CMMotionManager()
    
    /* Only used with simulator */
    var lastTouchPosition: CGPoint?
    
    /* Variables used for ball */
    var ball: SKShapeNode?
    let ballRadius: CGFloat = 50
    let ballSensitivity = 10.0
    let ballLinearDamping: CGFloat = 1.0
    
    /* Variables to keep track of screen size limitations */
    var xRange: SKRange?
    var yRange: SKRange?
    
    /* Variables used for hole */
    var hole: SKShapeNode?
    let holeRadius: CGFloat = 70
    var xHolePosition: CGFloat = 0.0
    var yHolePosition: CGFloat = 0.0
    let setMarginX: CGFloat = 20
    let setMarginY: CGFloat = 30
    let holeGenerationRate = 5
    
    /* Variables used to keep track of the timer */
    var counter = 60
    var counterTimer = Timer()
    
    
    /**
     Class constructor - obtains the parent class to be able to access IBOutlets
     
     - Returns: None.
     */
    init(size: CGSize, parent: TiltViewController) {
        
        self.viewController = parent
        super.init(size: size)
        
    }
    
    
    /**
     Required function because of self initialization of init()
     
     - Returns: None.
     */
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    /**
     Function runs when this current scene has been placed onto the view. Controls the main gameplay elements
     
     - Returns: None.
     */
    override func didMove(to view: SKView) {
        
        motionManager.startAccelerometerUpdates()
        
        ball = SKShapeNode(circleOfRadius: ballRadius)
        hole = SKShapeNode(circleOfRadius: holeRadius)
        
        xRange = SKRange(lowerLimit:CGFloat(ballRadius),upperLimit:size.width - CGFloat(ballRadius))
        yRange = SKRange(lowerLimit:CGFloat(ballRadius),upperLimit:size.height - CGFloat(ballRadius))
        
        physicsWorld.gravity = .zero
        
        showGameUI()
        startCounter()
        generateBall()
        
    }
    
    
    /**
     Displays game UI elements at the start of the game
     
     - Returns: None.
     */
    func showGameUI() {
        
        viewController.timeScoreUI.isHidden = false
        
    }
    
    
    /**
     Starts the game timer to keep track of time remaining
     
     - TODO: Set Game Over screen when countdown hits 0
     
     - Returns: None.
     */
    func startCounter() {
        
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
    }
    
    
    /**
     Helper function for the counter - also used for hole generation
     
     - Returns: None.
     */
    @objc func decrementCounter() {
        
        if (counter % holeGenerationRate == 0){
            generateHole()
        }
        
        counter -= 1
        viewController.timeLabel.text = String(counter)
        
    }
    
    
    /**
     Generates the Ball controlled by the user.
     
     - Returns: None.
     */
    func generateBall() {
        
        ball?.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(ballRadius))
        ball?.physicsBody?.allowsRotation = false
        ball?.physicsBody?.linearDamping = ballLinearDamping
        
        ball?.constraints = [SKConstraint.positionX(xRange!,y:yRange!)]
        
        ball?.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        ball?.fillColor = SKColor.white
        
        self.addChild(ball!)
        
    }
    
    
    /**
     Generates a new Hole and displays the new target on the screen.
     
     - Returns: None.
     */
    func generateHole() {
        
        hole?.removeFromParent()
        
        hole?.position = randomHolePosition()
        hole?.strokeColor = SKColor.red
        
        self.addChild(hole!)
        
    }
    
    
    /**
     Generates a  random (x, y) position for a Hole.
     
     - Returns: CGPoint containing xPosition and yPosition.
     */
    func randomHolePosition() -> CGPoint {
        
        xHolePosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxX)! + 1)))
        yHolePosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxY)! + 1)))
        
        /* Checks and ensures that the hole stays within the screen bounds */
        if xHolePosition < holeRadius {
            xHolePosition = holeRadius + setMarginX
        }
        else if xHolePosition > (view?.bounds.maxX)! - holeRadius {
            xHolePosition = (view?.bounds.maxX)! - holeRadius - setMarginX
        }
        
        if yHolePosition < holeRadius {
            yHolePosition = holeRadius + setMarginY
        }
        else if yHolePosition > ((view?.bounds.maxY)! - holeRadius) {
            yHolePosition = (view?.bounds.maxY)! - holeRadius - setMarginY
        }
        
        return CGPoint(x: xHolePosition, y: yHolePosition)
        
    }
    
    
    /**
     Override function for a touch event on the screen - only used for simulator as simulator does not contain accelerometer
     
     - Returns: None.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
        
    }
    
    
    /**
     Override function for a touch event on the screen - only used for simulator as simulator does not contain accelerometer
     
     - Returns: None.
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
        
    }
    
    
    /**
     Override function for a touch event on the screen - only used for simulator as simulator does not contain accelerometer
     
     - Returns: None.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastTouchPosition = nil
        
    }
    
    
    /**
     Updates the position of the ball and increases the score counter
     
     - TODO: score should only count up when the whole ball is in the hole
     
     - Parameter currentTime: TimeInterval.
     
     - Returns: None.
     */
    override func update(_ currentTime: TimeInterval) {
        
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - (ball?.position.x)!, y: currentTouch.y - (ball?.position.y)!)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * ballSensitivity, dy: accelerometerData.acceleration.y * ballSensitivity)
        }
        #endif
        
        if (hole?.frame.contains(ball!.position) ?? false) {
            viewController.currentScore += 1
            viewController.scoreLabel.text = String(viewController.currentScore)
        }
        
    }
}
