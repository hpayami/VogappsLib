//
//  CAAnimation.swift
//  VogappsLib
//
//  Created by Ogan on 28/09/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation

public extension CAAnimation {
    
    static func presentDampedEasingFunction() -> CAMediaTimingFunction{
        return CAMediaTimingFunction(controlPoints: 0.15, 1.3, 0.75, 1.05)
    }
    
    static func dismissDampedEasingFunction() -> CAMediaTimingFunction{
        return CAMediaTimingFunction(controlPoints: 0.25, -0.05, 0.85, -0.3)
    }
    
    static func fadeInAnimation(duration: TimeInterval) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        return animation
    }

    static func fadeOutAnimation(duration: TimeInterval) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 1
        animation.toValue = 0
        return animation
    }
    
    static func scaleAnimation(from:CGFloat,to: CGFloat, duration : TimeInterval) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.fromValue = from
        animation.toValue = to
        return animation
    }
    
    
    static func shrinkInAnimation(duration: TimeInterval) -> CAAnimation {
        let fadeInAnimation = self.fadeInAnimation(duration: duration)
        let scaleAnimation = self.scaleAnimation(from: 1.1, to: 1, duration: duration)
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = [fadeInAnimation, scaleAnimation]
        return group
    }

    static func growOutAnimation(duration: TimeInterval) -> CAAnimation {
        let fadeInAnimation = self.fadeOutAnimation(duration: duration)
        let scaleAnimation = self.scaleAnimation(from: 1, to: 1.1, duration: duration)
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = [fadeInAnimation, scaleAnimation]
        return group
    }
    
    static func verticalSlideAnimation(duration: TimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = duration
        return animation
    }
    
}
