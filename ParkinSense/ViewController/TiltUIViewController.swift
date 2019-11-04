//-----------------------------------------------------------------
//  File: TiltUIViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Dexter Bigueta, Hamlet Jiang Su
//
//  Changes:
//      - list change here
//
//  Known Bugs:
//      - list known bugs here
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class TiltUIViewController: UIViewController {

    @IBOutlet weak var StartGame: UIButton!
    
    @IBOutlet weak var QuitGame: UIButton!
    
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.StartGame.layer.cornerRadius = 25 // Rounded Start Button
        self.QuitGame.layer.cornerRadius = 25 // Rounded Quit Button
        
        guard let musicFile = Bundle.main.path(forResource: "Roots", ofType: ".mp3") else {
            print("File Not Found")
            return
        }
        
        do {
            try soundEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
            soundEffect.numberOfLoops = -1
        }
        
        catch {
            print(error)
        }
        
        soundEffect.play()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func SoundToggle(_ sender: UISwitch) {
        
        if (sender.isOn == false)
        {
            soundEffect.pause()
        }
        else{
            soundEffect.play()
        }
        
    }
    
    @IBAction func StopSound(_ sender: Any) {
        soundEffect.stop()
    }
    
    @IBAction func Startthegame(_ sender: Any) {
    }
    
}
