//-----------------------------------------------------------------
//  File: TiltViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: Main TILT view controller that presents the countdown and tilt game scenes
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Added comments to clarify code
//      - Added viewDidDisappear() and prepare() to transtition over to the Tilt Score View
//      - Added functions that help set up the countdown scene and transition to it
//      - Added view controller to the main storyboard
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import SpriteKit

class TiltViewController: UIViewController {
    
    var countdownScene: CountdownGameScene!
    var tiltGameScene: TiltGameScene!
    
    /* Variables related to game UI */
    var gameCountdown: Int = 30
    var currentScore: Int = 0
    
    //HUD view controls the time and score labels
    let HUDView: UIView = {
        let view = UIView()
        return view
    }()
    
    //Countdown view holds the countdown timer
    let countdownView: UIView = {
        let view = UIView()
        return view
    }()
    
    //Time header HUD label
    let timeStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.textColor = tiltTextColour // Set label text colour
        label.font = tiltStaticFont // Set label text font
        label.heightAnchor.constraint(equalToConstant: timeStaticLabelHeight).isActive = true // Set label height
        label.widthAnchor.constraint(equalToConstant: timeStaticLabelWidth).isActive = true // Set label width
        return label
    }()
    
    //Score header HUD label
    let scoreStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.textColor = tiltTextColour // Set label text colour
        label.font = tiltStaticFont // Set label text font
        label.heightAnchor.constraint(equalToConstant: scoreStaticLabelHeight).isActive = true // Set label height
        label.widthAnchor.constraint(equalToConstant: scoreStaticLabelWidth).isActive = true // Set label width
        return label
    }()
    
    //Current time UI label
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.font = tiltFont // Set label text font
        label.textColor = tiltTextColour // Set label text colour
        label.heightAnchor.constraint(equalToConstant: timeLabelHeight).isActive = true // Set label height
        label.widthAnchor.constraint(equalToConstant: timeLabelWidth).isActive = true // Set label width
        return label
    }()
    
    //Current score UI label
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.font = tiltFont // Set label text font
        label.textColor = tiltTextColour // Set label text colour
        label.heightAnchor.constraint(equalToConstant: scoreLabelHeight).isActive = true // Set label height
        label.widthAnchor.constraint(equalToConstant: scoreLabelWidth).isActive = true // Set label width
        return label
    }()
    
    //Countdown UI lable
    let countdownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center  // Set label text alignment
        label.textColor = countdownTextColour // Set label text colour
        label.font = countdownFont // Set label text font
        return label
    }()
    
    
    /**
     Function runs when this current view has been loaded. Creates countdown scene and transitions to it
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets background colour of view
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        //Adds the labels for countdown view only
        view.addSubview(countdownView)
        countdownView.addSubview(countdownLabel)
        
        //Set up constraints for countdown view
        countdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        countdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        countdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countdownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        startInitialCountdown()
    }
    
    
    /**
     Hides the status bar from view when this view is presented
     
     - Returns: None.
     */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func loadView() {
        self.view = SKView()
    }
    
    func setupGameUI(){
        //Removes countdown and displays HUD view
        countdownView.removeFromSuperview()
        view.addSubview(HUDView)
        
        //Add labels to HUD view
        HUDView.addSubview(timeStaticLabel)
        HUDView.addSubview(scoreStaticLabel)
        HUDView.addSubview(timeLabel)
        HUDView.addSubview(scoreLabel)
        
        timeStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        timeStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        // Set score label constraints to allow for multiple device configurations
        scoreStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        scoreStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        // Set time label constraints to allow for multiple device configurations
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: timeStaticLabel.topAnchor, constant: timeStaticLabelHeight + 8.0).isActive = true
        
        scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: scoreStaticLabel.topAnchor, constant: scoreStaticLabelHeight + 8.0).isActive = true
    }
    
    
    /**
     Initializes the first scene and displays it on the screen.
     
     - Returns: None.
     */
    func startInitialCountdown() {
        let skView = view as! SKView
        
        print("Set up Countdown")
        
        // Setup countdown
        setupCountdownScene()
        
        let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
        let scene:SKScene = CountdownGameScene(size: (self.view?.bounds.size)!, parent: self)
        skView.presentScene(scene, transition: transition)
        
    }
    
    
    /**
     Hides the main UI of the game containing the time and score during the countdown
     
     - Returns: None.
     */
    func setupCountdownScene() {
        // hide HUD and set the respective text labels
        HUDView.isHidden = true
        timeLabel.text = String(gameCountdown)
        scoreLabel.text = String(currentScore)
    }
    
    
    /**
     Sets the Tilt Game Scene to nil to allow ARC to remove it and deinitialize the scene
     
     - Returns: None.
     */
    override func viewDidDisappear(_ animated: Bool) {
        if (self.view as? SKView) != nil{
            // Remove view to be deallocated from memory
            self.view = nil
        }
    }

}

