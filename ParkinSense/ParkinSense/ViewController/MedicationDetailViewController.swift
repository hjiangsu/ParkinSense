//
//  MedicationDetailViewController.swift
//  CustomerLoginDemo
//
//  Created by weng Higgins on 2019-10-23.
//  Copyright © 2019 weng Higgins. All rights reserved.
//

import UIKit

class MedicationDetailViewController: UIViewController {
    
    @IBOutlet weak var MedicationTextField: UITextField!
    
    @IBOutlet var DateSelectionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func DateSelectionTapped(_ sender: UIButton) {
        
        
        //DateSelectionButtons.forEach({ $0.tintColor =  UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)})
        
        sender.tintColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        
    }
    

}
