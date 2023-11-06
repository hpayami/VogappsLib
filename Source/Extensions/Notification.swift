//
//  Notification.swift
//  Pods
//
//  Created by Ogan Topkaya on 24/03/2017.
//
//

import Foundation
import UIKit

public extension Notification{
    
    typealias KeyboardNotificationValues = (beginFrame: CGRect, endFrame: CGRect, duration: TimeInterval, animationOptions: UIView.AnimationOptions)
    
    var keyboardValues: KeyboardNotificationValues {
        let beginFrame = (userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        let endFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        let animationOptions = UIView.AnimationOptions(rawValue: (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt) ?? 0)
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        return (beginFrame: beginFrame, endFrame: endFrame, duration: animationDuration, animationOptions: animationOptions)
    }
    
}
