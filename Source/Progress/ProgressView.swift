//
//  ProgressView.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 26/06/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit

public protocol ProgressViewDelegate : class{
    func progressViewDidChangeProgress(_ progressView:ProgressView)
    func progressViewDidTickSecond(_ progressView:ProgressView, elapsedSeconds: Int)
    func progressViewDidCompletedProgress(_ progressView:ProgressView)
}

extension ProgressViewDelegate {
    public func progressViewDidChangeProgress(_ progressView:ProgressView){}
    public func progressViewDidTickSecond(_ progressView:ProgressView, elapsedSeconds: Int){}
    public func progressViewDidCompletedProgress(_ progressView:ProgressView){}
}

open class ProgressView : UIView {
    open weak var delegate: ProgressViewDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    open func configure(){
        self.contentMode = .redraw
        self.backgroundColor = UIColor.clear
    }
    
    @IBInspectable open var progress : CGFloat = 0.0
        {
        didSet{
            self.delegate?.progressViewDidChangeProgress(self)
            self.setNeedsDisplay()
        }
    }
    
    fileprivate var displayLink : CADisplayLink?
    fileprivate var animationFromValue : CGFloat?
    fileprivate var animationToValue : CGFloat?
    fileprivate var animationStartTime : CFTimeInterval?
    fileprivate var animationDuration : Double?
    fileprivate var totalElapsedTime : Double = 0.0

    open var elapsedTime : Double {
        get{
            return totalElapsedTime
        }
    }
    
    open func setProgress(_ progress:CGFloat,duration:Double){
        self.stopAndResetValues()
        
        self.animationStartTime = CACurrentMediaTime()
        self.animationFromValue = self.progress
        self.animationToValue = progress
        self.animationDuration = duration
        self.displayLink = CADisplayLink(target: self, selector: #selector(ProgressView.animateProgress(_:)))
        self.displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    open func pause(){
        guard let displayLink = self.displayLink,
            let animationStartTime = self.animationStartTime,
            let animationDuration = self.animationDuration,
            let _ = self.animationFromValue,
            let _ = self.animationToValue else{
                return
        }
        
        self.animationDuration = animationDuration - (displayLink.timestamp - animationStartTime)
        self.stop()
    }
    
    open func resume(){
        guard let _ = self.animationStartTime,
            let _ = self.animationFromValue,
            let animationDuration = self.animationDuration,
            let animationToValue = self.animationToValue else{
                return
        }
        
        if(self.displayLink == nil || self.displayLink?.isPaused ?? true){
            setProgress(animationToValue, duration: animationDuration)
        }
    }
    
    open func stop(){
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
    
    @objc func animateProgress(_ displayLink : CADisplayLink){
        DispatchQueue.main.async{
            guard let displayLink = self.displayLink,
                let animationStartTime = self.animationStartTime,
                let animationDuration = self.animationDuration,
                let animationFromValue = self.animationFromValue,
                let animationToValue = self.animationToValue else{
                    self.stopAndResetValues()
                    return
            }
            
            self.calculateTotalElapsedTime(displayLink)
            let dt = (displayLink.timestamp - animationStartTime) / animationDuration
            if dt >= 1.0{
                self.stopAndResetValues()
                self.progress = animationToValue
                self.delegate?.progressViewDidCompletedProgress(self)
            }
            else {
                self.progress = animationFromValue + CGFloat(dt) * (animationToValue - animationFromValue)
            }
        }
    }
    
    func calculateTotalElapsedTime(_ displayLink : CADisplayLink){
        let temp = totalElapsedTime
        totalElapsedTime += displayLink.duration
        let elapsed = floor(totalElapsedTime) - floor(temp)
        if(elapsed != 0){
            self.delegate?.progressViewDidTickSecond(self, elapsedSeconds: Int(totalElapsedTime))
        }
    }
    
    override open func removeFromSuperview() {
        self.stopAndResetValues()
        super.removeFromSuperview()
    }
    
    fileprivate func stopAndResetValues(){
        self.stop()
        displayLink = nil
        animationFromValue = nil
        animationToValue = nil
        animationStartTime = nil
        animationDuration = nil
        totalElapsedTime = 0.0
    }
    
    deinit{
        stop()
    }
}

