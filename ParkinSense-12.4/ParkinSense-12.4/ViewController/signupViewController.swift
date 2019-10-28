//
//  signupViewController.swift
//  CustomerLoginDemo
//
//  Created by weng Higgins on 2019-10-22.
//  Copyright © 2019 weng Higgins. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class signupViewController: UIViewController {

    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var MedicationLabel: UILabel!
    
    @IBOutlet weak var CreateanAccountButton: UIButton!
    
    @IBOutlet weak var AddNewMedicationDetailButton: UIButton!
    
    @IBOutlet weak var AlreadyhaveanaccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElement()
        
    }
    
    func setUpElement(){
        
        //Hide the error label
        ErrorLabel.alpha = 0
        
        MedicationLabel.alpha = CGFloat(medicationLabelalpha)
        
        MedicationLabel.text = MedicationName
        
        UsernameTextField.text = Username
        
        PasswordTextField.text = Password
        
        //Style the elements
        Utilities.styleTextField(UsernameTextField)
        
        Utilities.styleTextField(PasswordTextField)
        
        Utilities.styleTextField(ConfirmPasswordTextField)
        
        Utilities.styleHollowButton(CreateanAccountButton)
        
        Utilities.styleFilledButton(AddNewMedicationDetailButton)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func validateFilds() -> String? {
        
        //Check that all fields are filled in
        if UsernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ConfirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
            
        }
        
        if PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ConfirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines){
            
            return "Pleace make sure the password is matched"
        }
        
        return nil
        
    }
    
    @IBAction func CreateanAccounttapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateFilds()
        
        if error != nil{
            
            //There's something wrong with the fields, show error message
            showError(error!)
        }
        else{
            //Create cleaned versions of the data
            Username = UsernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: Username, password: Password) { (result, err) in
                
                //Check for errors
                if err != nil {
                    
                    //There was an error creating the user
                    self.showError("Error creating user")
                }
                else
                {
                    //User was created successfully, now store the username
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["Username": Username, "uid": result!.user.uid, "MedicationName": MedicationName]) { (error) in
                        
                        if error != nil {
                            //Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    //Transition to the home screen
                    // self.transitionToHome()
                    self.performSegue(withIdentifier: "signUpToHomeID", sender: nil)
                }
            }
            
        }

        
    }
    
    @IBAction func AddNewMedicationDetailTapped(_ sender: Any) {
        Username = UsernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @IBAction func Alreadyhaveanaccounttapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindTologin", sender: nil)
    }
    
    @IBAction func unwindTosignup(segue: UIStoryboardSegue){
        
    }
    
    func showError(_ message:String){
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
//    func transitionToHome() {
//
//        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
//    }
    
}
