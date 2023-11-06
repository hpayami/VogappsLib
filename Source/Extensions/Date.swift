//
//  NSDate.swift
//  Pods
//
//  Created by Ogan Topkaya on 14/04/16.
//
//

import Foundation

public extension Date{
    
    static func progress(startDate: Date, endDate: Date) -> Double{
        let currentTimestamp = Date.timeIntervalSinceReferenceDate
        let startTimestamp = startDate.timeIntervalSinceReferenceDate
        let endTimestamp = endDate.timeIntervalSinceReferenceDate
        
        if endTimestamp <= startTimestamp {
            return 1 // Not valid
        }
        else if currentTimestamp <= startTimestamp{
            return 0 // Not started
        }
        else if currentTimestamp >= endTimestamp {
            return 1 // Completed
        }
        else {
            return (currentTimestamp - startTimestamp) / (endTimestamp - startTimestamp)
        }
    }
    
    static func numberOfDaysBetween(dates date1:Date, _ date2:Date) -> Int{
        return Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: date1), to: Calendar.current.startOfDay(for: date2)).day ?? 0
    }
    
    func numberOfDaysFromNow() -> Int {
        return Date.numberOfDaysBetween(dates: Date(), self)
    }
    
}

