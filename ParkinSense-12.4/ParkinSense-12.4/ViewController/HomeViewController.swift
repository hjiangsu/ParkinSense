//
//  HomeViewController.swift
//  CustomerLoginDemo
//
//  Created by weng Higgins on 2019-10-22.
//  Copyright © 2019 weng Higgins. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var GameOneButton: UIButton!
    
    @IBOutlet weak var GameTwoButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
        var currentYear = Calendar.current.component(.year, from: Date())
    //    var currentMonth = Calendar.current.component(.month, from: Date())
        var currentWeek = Calendar.current.component(.weekOfYear, from: Date())
    //    var currentDate = Calendar.current.component(.day, from: Date())
    //    var currentWeekday = Calendar.current.component(.weekday, from: Date())
        var rightNow = Date()
        
        
        var Weeks = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6", "Week 7", "Week 8", "Week 9", "Week 10", "Week 11", "Week 12", "Week 13", "Week 14", "Week 15", "Week 16", "Week 17", "Week 18", "Week 19", "Week 20", "Week 21", "Week 22", "Week 23", "Week 24", "Week 25", "Week 26", "Week 27", "Week 28", "Week 29", "Week 30", "Week 31", "Week 32", "Week 33", "Week 34", "Week 35", "Week 36", "Week 37", "Week 38", "Week 39", "Week 40", "Week 41", "Week 42", "Week 43", "Week 44", "Week 45", "Week 46", "Week 47", "Week 48", "Week 49", "Week 50", "Week 51",  "Week 52"]
        
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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        setUp(newformattedtartcurrentweek: formattedstartcurrentweek, newformattedendcurrentweek: formattedendcurrentweek)
        sevendaydate(currentdate: rightNow)
        popover()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func popover(){
        let alert = UIAlertController(title: "Reminder", message: "Did you take your medicine today?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert,animated: true)
    }
    
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
    
    @IBAction func GameOneButtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func GameTwoButtonPressed(_ sender: Any) {
    }
    
}
