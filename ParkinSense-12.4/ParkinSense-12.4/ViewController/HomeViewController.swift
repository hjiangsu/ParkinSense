//
//  HomeViewController.swift
//  CustomerLoginDemo
//
//  Created by weng Higgins on 2019-10-22.
//  Copyright © 2019 weng Higgins. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var GameOneButton: UIButton!
    
    @IBOutlet weak var GameTwoButton: UIButton!
    
    var ref: DatabaseReference?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //userid = Auth.auth().currentUser!.uid
        
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
        var currentYear = Calendar.current.component(.year, from: Date())
    //    var currentMonth = Calendar.current.component(.month, from: Date())
        var currentWeek = Calendar.current.component(.weekOfYear, from: Date())
    //    var currentDate = Calendar.current.component(.day, from: Date())
    //    var currentWeekday = Calendar.current.component(.weekday, from: Date())
        var rightNow = Date()
        
        
        @IBOutlet weak var weekdateLabel: UILabel!
        
        @IBOutlet weak var PrevWeek: UIButton!
        
        @IBOutlet weak var NextWeek: UIButton!
        
        
        @IBOutlet weak var SundayButton: UIButton!
        @IBOutlet weak var MondayButton: UIButton!
        @IBOutlet weak var TuesdayButton: UIButton!
        @IBOutlet weak var WednesdayButton: UIButton!
        @IBOutlet weak var ThursdayButton: UIButton!
        @IBOutlet weak var FridayButton: UIButton!
        @IBOutlet weak var SaturdayButton: UIButton!
        
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        // Do any additional setup after loading the view.
        setUp(newformattedtartcurrentweek: formattedstartcurrentweek, newformattedendcurrentweek: formattedendcurrentweek)
        sevendaydate(currentdate: rightNow)
        //getlogintime()

        
        ref = Database.database().reference()
        userid = Auth.auth().currentUser!.uid
        
        let db = Firestore.firestore()
        db.collection("users").document(userid).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let DocumentData = document!.data()
                    //print (DocumentData!)
                    Username = DocumentData!["Username"] as! String
                    MedicationName = DocumentData!["MedicationName"] as! String
                    let lasttimeLogin = DocumentData!["login_time"] as! Timestamp
                    //print(lasttimeLogin.dateValue())
                    let lasttimeLogindate = lasttimeLogin.dateValue()
                    dateformatter.dateFormat = "yyyy/MM/dd"
                    lasttimeLogindatestr = dateformatter.string(from: lasttimeLogindate)
                    //print(lasttimeLogindatestr)
                    thistimeLogindatestr = dateformatter.string(from: Date())
                    //print(thistimeLogindatestr)
                    if lasttimeLogindatestr != thistimeLogindatestr{
                         //print("in popover")
                        self.popover()
                     }
                }
            }

        }
        
        //print(userid)
//        db.collection("users").document(userid).setData(["login_time": rightNow, "Username": Username, "MedicationName": MedicationName, "uid":userid])
        
 
        
        
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
        Function to set up the pops up
     
         - Parameters: No
         - Returns: No
     
         - TODO: Set the mood, not display for medicine
            
    **/
    
    func popover(){
        let alert = UIAlertController(title: "Reminder", message: "Did you take your medicine today?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        db.collection("users").document(userid).setData(["login_time": rightNow, "Username": Username, "MedicationName": MedicationName, "uid":userid])
        
        self.present(alert,animated: true)
    }
    
    /**
        Function for displaying next week date by clicking the next week button
     
         - Parameters: Button itself
         - Returns: No
            
    **/
    
    @IBAction func NextWeekButton(_ sender: Any) {
            let nextweek = rightNow + 3600*24*7
            rightNow = nextweek
            sevendaydate(currentdate: rightNow)
            
            let newformattedtartcurrentweek = newstartcurrentweek(updateNow: rightNow)
            let newformattedendcurrentweek = newendcurrentweek(updateNow: rightNow)
            currentWeek += 1
            if currentWeek == 53 {
                currentWeek = 1
                currentYear += 1
            }
            setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        }
        
    /**
        Function for displaying prev week date by clicking the next week button
     
         - Parameters: Button itself
         - Returns: No
            
    **/
        
        @IBAction func PrevWeekButton(_ sender: Any) {
            let nextweek = rightNow - 3600*24*7
            rightNow = nextweek
            sevendaydate(currentdate: rightNow)
            
            let newformattedtartcurrentweek = newstartcurrentweek(updateNow: rightNow)
            let newformattedendcurrentweek = newendcurrentweek(updateNow: rightNow)
            
            currentWeek -= 1
            if currentWeek == 0 {
                currentWeek = 52
                currentYear -= 1
            }
            setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        }
        
    /**
        Function to  set up the calendar appearance
     
         - Parameter newformattedtartcurrentweek: String
         - Parameter newformattedendcurrentweek: String
         - Returns: No
            
    **/
        
        
        func setUp(newformattedtartcurrentweek: String, newformattedendcurrentweek: String)
        {
            weekdateLabel.text = "\(newformattedtartcurrentweek)" + " ~ " + "\(newformattedendcurrentweek)"
            
            Utilities.styleFilledDateButton(SundayButton)
            Utilities.styleFilledDateButton(MondayButton)
            Utilities.styleFilledDateButton(TuesdayButton)
            Utilities.styleFilledDateButton(WednesdayButton)
            Utilities.styleFilledDateButton(ThursdayButton)
            Utilities.styleFilledDateButton(FridayButton)
            Utilities.styleFilledDateButton(SaturdayButton)
            //Utilities.styleFilledButton(NextWeek)
            //Utilities.styleFilledButton(PrevWeek)
            
        }
    /**
        Function to  update  date in calender in constant
     
         - Parameter currentdate: Date
         - Returns: No
            
    **/
        
        func sevendaydate(currentdate: Date){
            
            let SundayDate = Sundaydate(startcurrentweek: currentdate)
            let MondayDate = Mondaydate(startcurrentweek: currentdate)
            let TuesdayDate = Tuesdaydate(startcurrentweek: currentdate)
            let WednesdayDate = Wednesdaydate(startcurrentweek: currentdate)
            let ThursdayDate = Thursdaydate(startcurrentweek: currentdate)
            let FridayDate = Fridaydate(startcurrentweek: currentdate)
            let SaturdayDate = Saturdaydate(startcurrentweek: currentdate)
            SundayButton.setTitle(SundayDate, for: .normal)
            MondayButton.setTitle(MondayDate, for: .normal)
            TuesdayButton.setTitle(TuesdayDate, for: .normal)
            WednesdayButton.setTitle(WednesdayDate, for: .normal)
            ThursdayButton.setTitle(ThursdayDate, for: .normal)
            FridayButton.setTitle(FridayDate, for: .normal)
            SaturdayButton.setTitle(SaturdayDate, for: .normal)
        }
    
//    func getlogintime(){
//
//        ref?.updateChildValues(["login_time": [rightNow]])
//
//        print(rightNow)
//    }

    
    /**
        Function about the Game One Button, will direct you to the Game One page
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func GameOneButtnPressed(_ sender: Any) {
    }
    
    /**
        Function about the Game Two Button, will direct you to the Game Two page
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func GameTwoButtonPressed(_ sender: Any) {
    }
    
}
