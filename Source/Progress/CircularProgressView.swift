//
//  CircularProgressView.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 26/06/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit

@IBDesignable
open class CircularProgressView: ProgressView {
    @IBInspectable open var primaryColor : UIColor = UIColor(rgba: "#a2c000")
    {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable open var progressColor : UIColor = UIColor(rgba: "#7e9500")
    {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable open var startAngle : CGFloat = -90
        {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    
    override open func draw(_ rect: CGRect) {
        let centerPoint = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        
        let bestSquareFitFrame = self.bounds.bestSquareToFitInCenter(withPadding: 0)
        let bezierPath = UIBezierPath(ovalIn: bestSquareFitFrame)
        primaryColor.setFill()
        bezierPath.fill()
        
        let angle = lerp(0.0, 360.0, progress)
        let endAngle = radians(angle + startAngle)
        
        let arcPath = UIBezierPath(arcCenter: centerPoint, radius: bestSquareFitFrame.size.width/2, startAngle: radians(startAngle), endAngle: endAngle, clockwise: true)
        arcPath.addLine(to: centerPoint)
        
        progressColor.setFill()
        arcPath.fill()
    }
}
