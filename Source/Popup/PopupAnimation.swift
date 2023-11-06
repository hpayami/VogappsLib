//
//  PopupAnimation.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 03/11/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation

public enum PopupAnimation{
    case none
    case shrinkIn
    case growOut
    case slideUp
    case slideDown
    case fadeIn
    case fadeOut
}

public struct PopupAnimationFactory{
    static func animation(_ type:PopupAnimation, duration: TimeInterval) -> CAAnimation {
        switch type{
        case .none:
            return CAAnimation()
        case .shrinkIn:
            return CAAnimation.shrinkInAnimation(duration: duration)
        case .growOut:
            return CAAnimation.growOutAnimation(duration: duration)
        case .slideUp:
            let animation = CAAnimation.verticalSlideAnimation(duration: duration)
            animation.timingFunction = CAAnimation.presentDampedEasingFunction()
            return animation
        case .slideDown:
            let animation = CAAnimation.verticalSlideAnimation(duration: duration)
            animation.timingFunction = CAAnimation.dismissDampedEasingFunction()
            return animation
        case .fadeIn:
            return CAAnimation.fadeInAnimation(duration: duration)
        case .fadeOut:
            return CAAnimation.fadeOutAnimation(duration: duration)
        }
    }
}
