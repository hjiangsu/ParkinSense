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
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var AddNewMedicationButton: UIButton!
    
    var isDateSelect: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timePicker?.datePickerMode = .time
        
        timePicker.timeZone = NSTimeZone.local
        
        setUpElements()
        
        
    }
    

    /**
        Function for set up the appearance of the medication detail page
     
         - Parameters: No
     
         - Returns: No
            
    **/
    
    func setUpElements(){
        
        Utilities.styleFilledButton(AddNewMedicationButton)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**
        Function about change the day button appearene clicking or not clicking
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func DateSelectionTapped(_ sender: UIButton) {
        
        
        //DateSelectionButtons.forEach({ $0.tintColor =  UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)})
        isDateSelect.toggle()
        
        if isDateSelect{
            sender.tintColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
        else{
            sender.tintColor = UIColor.init(red: 169/255, green: 170/255, blue: 171/255, alpha: 1)
        }
        
        
    }
    
    /**
        Function about the add new medication Button, will direct you back to the sign up page and medication will be displayed on the screen
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func AddNewMedicationButton(_ sender: Any) {
        
        MedicationName = MedicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        timepickertime = dateFormatter.string(from: timePicker.date)
        
        print(timepickertime)
        
        medicationLabelalpha = 1
        
        //self.performSegue(withIdentifier: "unwindTosignup", sender: self)
    }
    

}
