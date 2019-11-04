//-----------------------------------------------------------------
//  File: LoginViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Changes:
//      - list change here
//
//  Known Bugs:
//      - list known bugs here
//
//-----------------------------------------------------------------

import UIKit
import FirebaseAuth
import FirebaseDatabase


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
    
    /**
        Function to set up the default ErrorLabel invisiable and set up the button and text appearance
     
         - Parameters: No
         - Returns: No
            
    **/
    
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

    /**
        Function about the Remember Password Button check or uncheck
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
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
    
    /**
        Function about the Sign in Button, will direct you to the home page if success. If not, the error will be displayed
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func SigninTapped(_ sender: Any) {
        
        //validate Text Fields
        
        //Create cleaned versions of the text field
        username = UsernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            
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
    
    /**
        Function about the Create Account Button, will direct you to the Sign up page
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func CreateAccountTapped(_ sender: Any) {
    }
    
    /**
        Function about the Back to the current  page Button,  
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func unwindTologin(segue: UIStoryboardSegue){
        
    }
    
}
