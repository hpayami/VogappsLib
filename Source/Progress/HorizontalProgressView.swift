//
//  Horizontal.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 29/02/16.
//
//

import Foundation

@IBDesignable
open class HorizontalProgressView: ProgressView {
    
    public enum ProgressOrigin{
        case left
        case right
    }
    
    open var progressOrigin:ProgressOrigin = .left {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    open var primaryColor : UIColor = UIColor(rgba: "#F2F1F1"){
        didSet{
            self.setNeedsDisplay()
        }
    }
    open var progressColor : UIColor = UIColor(rgba: "#0080FC"){
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override open func draw(_ rect: CGRect) {
        let primaryPath = UIBezierPath(rect: self.bounds)
        primaryColor.setFill()
        primaryPath.fill()
        

        let progressPathWidth = lerp(Float(0.0), Float(self.bounds.size.width), Float(progress))
        
        if progressOrigin == .left{
            let progresspath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: CGFloat(progressPathWidth), height: self.bounds.size.height))
            progressColor.setFill()
            progresspath.fill()
        }
        else {
            let progresspath = UIBezierPath(rect: CGRect(x: self.bounds.size.width - CGFloat(progressPathWidth), y: 0, width: CGFloat(progressPathWidth), height: self.bounds.size.height))
            progressColor.setFill()
            progresspath.fill()
        }
    }
}


