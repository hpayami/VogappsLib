//
//  CountdownLabel.swift
//  CountdownLabel
//
//  Created by Ogan Topkaya on 03/09/16.
//  Copyright © 2016 countdown. All rights reserved.
//

import Foundation
import UIKit

public protocol TimerLabelDelegate: class {
    func countdownLabel(didUpdate countdownLabel: TimerLabel)
    func countdownLabel(didFinishCountdown countdownLabel: TimerLabel)
}

open class TimerLabel: UILabel{
    open weak var delegate: TimerLabelDelegate?
    fileprivate var timer: Timer?
    
    open fileprivate(set) var elapsedTime: TimeInterval=0
    open fileprivate(set) var remainingTime: TimeInterval=0
    open fileprivate(set) var totalTime: TimeInterval=0
    
    open var updateHandler : ((_ timer: TimerLabel) -> ())?
    open var completionHandler: ((_ timer: TimerLabel) -> ())?
    
    fileprivate var countdownStartDate: Date?
    fileprivate var countdownEndDate: Date?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    fileprivate func configure(){
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification){
        self.remainingTime = self.countdownEndDate?.timeIntervalSinceNow ?? 0
        self.elapsedTime = -(self.countdownStartDate?.timeIntervalSinceNow ?? 0)
        self.totalTime = self.remainingTime + self.elapsedTime
        
        self.update()
        if self.remainingTime <= 0{
            self.completionHandler?(self)
            self.delegate?.countdownLabel(didUpdate: self)
            disposeTimer()
        }
        else {
            startTimer()
        }
    }
    
    func startTimer(){
        self.disposeTimer()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerLabel.timerCallback), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func timerCallback(){
        self.elapsedTime = self.elapsedTime+1
        self.remainingTime = self.remainingTime-1
        
        self.update()
        if self.remainingTime <= 0{
            self.completionHandler?(self)
            self.delegate?.countdownLabel(didUpdate: self)
            disposeTimer()
        }
    }
    
    func update(){
        self.updateHandler?(self)
        self.delegate?.countdownLabel(didUpdate: self)
    }
    
    func reset(){
        self.countdownStartDate = nil
        self.countdownEndDate = nil
        
        self.totalTime = 0
        self.remainingTime = 0
        self.elapsedTime = 0
    }
    
    func disposeTimer(){
        if timer?.isValid == true {
            timer?.invalidate()
        }
        timer = nil
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}

extension TimerLabel {
    public func countdown(duration: TimeInterval){
        disposeTimer()
        if duration > 0 {
            self.reset()
            self.totalTime = remainingTime
            self.remainingTime = duration
            self.countdownStartDate = Date()
            self.countdownEndDate = Date(timeIntervalSinceNow: duration)
            
            self.update()
            self.startTimer()
        }
        else {
            self.reset()
            self.update()
        }
    }
    
    public func countdown(toDate date:Date){
        disposeTimer()
        
        let remainingTime = date.timeIntervalSinceNow
        if remainingTime > 0 {
            self.reset()
            self.totalTime = remainingTime
            self.remainingTime = remainingTime
            self.countdownStartDate = Date()
            self.countdownEndDate = date
            
            self.update()
            self.startTimer()
        }
        else {
            self.reset()
            self.update()
        }
    }
    
    public func pause(){
        self.disposeTimer()
    }
    
    public func resume(){
        self.startTimer()
    }
    
    public func stop(){
        self.disposeTimer()
    }
    
    public var isActive: Bool {
        return self.timer?.isValid ?? false
    }
    
}



