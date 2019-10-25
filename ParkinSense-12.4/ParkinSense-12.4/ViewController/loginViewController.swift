//
//  loginViewController.swift
//  CustomerLoginDemo
//
//  Created by weng Higgins on 2019-10-22.
//  Copyright © 2019 weng Higgins. All rights reserved.
//

import UIKit
import FirebaseAuth


class loginViewController: UIViewController {

    
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var RememberPasswordLabel: UILabel!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var SigninButton: UIButton!
    
    @IBOutlet weak var ORlabel: UILabel!
    
    @IBOutlet weak var CreateanAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        btnCheckBox.setImage(UIImage(named:"uncheckbox"), for: .normal)
        btnCheckBox.setImage(UIImage(named:"checkbox"), for: .selected)
    }
    
    func setUpElements(){
        
        //Hide the error label
        ErrorLabel.alpha = 0
        
        //Style the elements 
        Utilities.styleTextField(UsernameTextField)
        
        Utilities.styleTextField(PasswordTextField)
        
        Utilities.styleFilledButton(SigninButton)
        
        Utilities.styleFilledButton(CreateanAccountButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        
    }
    
    @IBAction func SigninTapped(_ sender: Any) {
        
        //validate Text Fields
        
        //Create cleaned versions of the text field
        let Username = UsernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let Password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: Username, password: Password) { (result, error) in
            
            if error != nil {
                //could not sign in
                self.ErrorLabel.text = error!.localizedDescription
                self.ErrorLabel.alpha = 1
            }
            else{
                self.performSegue(withIdentifier: "loginToHomeID", sender: nil)
            }
        }
        
    }
    
    @IBAction func CreateAccountTapped(_ sender: Any) {
    }
    
    @IBAction func unwindTologin(segue: UIStoryboardSegue){
        
    }
    
}
