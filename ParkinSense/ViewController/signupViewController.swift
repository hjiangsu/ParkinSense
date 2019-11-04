//-----------------------------------------------------------------
//  File: SignupViewController.swift
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
    
    /**
        Function to set up the default ErrorLabel invisiable and set up the button and text appearance
     
         - Parameters: No
         - Returns: No
            
    **/
    
    func setUpElement(){
        
        //Hide the error label, medication label and save the Username and Password
        ErrorLabel.alpha = 0
        
        MedicationLabel.alpha = CGFloat(medicationLabelAlpha)
        
        MedicationLabel.text = medicationName
        
        UsernameTextField.text = username
        
        PasswordTextField.text = password
        
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
    
    /**
        Function to get the error message from text field for username and password
     
         - Parameters: No
         - Returns: String
            
    **/
    
    func validateFilds() -> String? {
        
        //Check that all fields are filled in
        if UsernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ConfirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
            
        }
        //check the password match the confirm password
        if PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ConfirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines){
            
            return "Pleace make sure the password is matched"
        }
        
        return nil
        
    }
    
    /**
        Function about Create Account Button, will make you access to the main page if sign up successfull. If not will give you the error message
     
         - Parameter sender: Button itself
         - Returns: No
            
    **/
    
    @IBAction func CreateanAccounttapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateFilds()
        
        if error != nil{
            
            //There's something wrong with the fields, show error message
            showError(error!)
        }
        else{
            //Create cleaned versions of the data
            username = UsernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: username, password: password) { (result, err) in
                
                //Check for errors
                if err != nil {
                    if password.count < 6{
                        self.showError("password must be at least 6 characters")
                    }
                    //There was an error creating the user
                    else{
                        self.showError("User Account should be valid email address")
                    }
                }
                else
                {
                    //User was created successfully, now store the username
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["Username": username, "uid": result!.user.uid, "MedicationName": medicationName, "login_time":rightNow - 3600*24]) { (error) in
                        
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
    
    /**
        Function about Add New Medication Button, will direct you to Medication Detail Page, and save the username and password into constant which later on when you back to the page, the username and password still remaining in the sign up page
     
         - Parameter sender: Button itself
         - Returns: No
            
    **/
    
    @IBAction func AddNewMedicationDetailTapped(_ sender: Any) {
        username = UsernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /**
        Function about Already Have Account  Button, will direct you back to signup page
     
         - Parameter sender: Self Button
         - Returns: No
            
    **/
    
    @IBAction func Alreadyhaveanaccounttapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindTologin", sender: nil)
    }
    
    /**
        Function about the Back to the current  page Button,
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func unwindTosignup(segue: UIStoryboardSegue){
        
    }
    
    /**
         If the Error occur, the error will show in the screen 
      
          - Parameter sender: Button itself
      
          - Returns: No
             
     **/
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
