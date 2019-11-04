//-----------------------------------------------------------------
//  File: TimeandExtension.swift
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

import Foundation
import UIKit

extension Date {
    //get the formatted time for later use
    static func calculateTime(hour:Int, minute: Int) -> Date {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculatedTime = formatter.date(from: "\(hour):\(minute)")
        
        return calculatedTime!
    }
    
}
