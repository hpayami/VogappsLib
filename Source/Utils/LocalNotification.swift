//
//  LocalNotification.swift
//  VogappsLib
//
//  Created by Volkan Demircin on 04/10/16.
//  Copyright © 2016 Vogapps. All rights reserved.
//

import Foundation
import UserNotifications

public class LocalNotification
{
    // TODO: Repeat defaults to false. Repeat mechanism works different with UNNotification and UILocalNotification. 
    // Will add repeat mechanism later.
    
    public static func scheduleLocalNotification (
        after duration: TimeInterval,
        title: String,
        body: String,
        identifier: String )
    {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.categoryIdentifier = identifier
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats:false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        } else {
            let date = Date(timeIntervalSinceNow: duration)
            scheduleLocalNotification(with: date, title: title, body: body, identifier: identifier)
        }
    }
    
    public static func scheduleLocalNotification (
        with date: Date,
        title: String,
        body: String,
        identifier: String )
    {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.categoryIdentifier = identifier
            content.sound = UNNotificationSound.default
            
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone.current
            let dateComponents = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        } else {
            let notification = UILocalNotification()
            notification.alertTitle = title
            notification.alertBody = body
            notification.userInfo = ["type": identifier]
            notification.timeZone = TimeZone.current
            notification.fireDate = date
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    public static func cancelLocalNotification (withIdentifier identifier: String)
    {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        } else {
            UIApplication.shared.scheduledLocalNotifications?.forEach{ (notification: UILocalNotification) in
                if let notificationType = notification.userInfo?["type"] as? String,
                    notificationType == identifier {
                    UIApplication.shared.cancelLocalNotification(notification)
                }
            }
        }
    }
    
    public static func cancelAllLocalNotifications()
    {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
}

