//
//  TimeandExtension.swift
//  ParkinSense
//
//  Created by weng Higgins on 2019-10-23.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

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
