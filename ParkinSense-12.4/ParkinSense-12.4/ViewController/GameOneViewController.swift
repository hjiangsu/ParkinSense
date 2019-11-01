//
//  GameOneViewController.swift
//  ParkinSense-12.4
//
//  Created by weng Higgins on 2019-10-24.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import UIKit

class GameOneViewController: UIViewController {

    @IBOutlet weak var StartGame: UIButton!
    
    @IBOutlet weak var QuitGame: UIButton!
    //@IBOutlet weak var myRoundedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StartGame.layer.cornerRadius = 25
        self.QuitGame.layer.cornerRadius = 25

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

    @IBAction func Startthegame(_ sender: Any) {
    }
    
}
