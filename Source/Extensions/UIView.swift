//
//  UIView.swift
//  VogappsLib
//
//  Created by Ogan on 21/07/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit

public extension UIView{
    func setAnchorPointWithoutEffectingTransform(_ anchorPoint: CGPoint) {
        let oldOrigin = self.frame.origin
        self.layer.anchorPoint = anchorPoint
        let newOrigin = self.frame.origin
        
        let transition = CGPoint (x: newOrigin.x - oldOrigin.x, y: newOrigin.y - oldOrigin.y)
        self.center = CGPoint (x: self.center.x - transition.x, y: self.center.y - transition.y)
        
    }
    
    func removeAllSubviews(){
        let subviews = self.subviews as NSArray
        for subview in subviews{
            (subview as AnyObject).removeFromSuperview()
        }
    }
    
    func findSubviews<T: UIView>(ofKind:T.Type) -> [T]?{
        return self.subviews.filter{
            return $0.isKind(of: T.self)
            } as? [T]
    }
    
    @discardableResult
    func showBorder<T: UIView>(color: UIColor, width: CGFloat) -> T{
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        return self as! T
    }
    
    func snapshot() -> UIImage {
        return UIUtilities.snapshot(for: self)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

public extension UIView{
    @available(*,deprecated,message: "Use UIView.fromNib() instead")
    class func createViewFromNib<T : UIView>(nibName: String,forClass: T.Type) -> (T?){
        return UINib(nibName:nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
    }
    
    func showDebugBorder(){
        showDebugBorder(UIColor.red)
    }
    
    func showDebugBorder(_ color:UIColor){
        self.layer.borderColor = color.cgColor;
        self.layer.borderWidth = 0.6
    }
    
    func setCornerRadius(_ radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

public extension UIView {
    class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil, type: T.self)
        return v!
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}

/// Transition
public extension UIView{
    func insertSubview(_ view: UIView, below: UIView, withTransition transition:CAAnimation,completion: (()->())? = {}){
        animateTransition({
            self.insertSubview(view, belowSubview: below)
            view.layer.add(transition, forKey: "presentAnimationKey")
            }, completion: completion)
    }
    
    func insertSubview(_ view: UIView, above: UIView,withTransition transition:CAAnimation,completion: (()->())? = {}){
        animateTransition({
            self.insertSubview(view, aboveSubview: above)
            view.layer.add(transition, forKey: "presentAnimationKey")
            }, completion: completion)
    }
    
    func insertSubview(_ view: UIView, atIndex index: Int,withTransition transition:CAAnimation,completion: (()->())? = {}){
        animateTransition({
            self.insertSubview(view, at: index)
            view.layer.add(transition, forKey: "presentAnimationKey")
            }, completion: completion)
    }
    
    func addSubview(_ view: UIView, withTransition transition:CAAnimation,completion: (()->())? = {}){
        animateTransition({
            self.addSubview(view)
            view.layer.add(transition, forKey: "presentAnimationKey")
            }, completion: completion)
    }
    
    func animateTransition(_ transition: ()->() , completion: (()->())? = {}){
        self.isUserInteractionEnabled = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ () -> Void in
            self.isUserInteractionEnabled = true
            completion?()
        })
        
        transition()
        CATransaction.commit()
    }
    
    func removeFromSuperview(withTransition transition:CAAnimation,completion: (()->())? = {}){
        if(self.layer.animation(forKey: "dismissAnimation") == nil){
            self.isUserInteractionEnabled = false
            CATransaction.begin()
            CATransaction.setCompletionBlock({ () -> Void in
                self.isHidden  = true
                self.removeFromSuperview()
                completion?()
                
                self.layer.removeAnimation(forKey: "dismissAnimation")
            })
            
            transition.isRemovedOnCompletion = false
            transition.fillMode = CAMediaTimingFillMode.forwards
            
            self.layer.add(transition, forKey: "dismissAnimation")
            CATransaction.commit()
        }
    }
    
    var centerPoint : CGPoint{
        return CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    
}

public extension UIResponder {
    
    func firstResponderViewController ()->(UIViewController?) {
        var nextResponder : UIResponder? = self
        while nextResponder != nil {
            if let nextResponder = nextResponder , nextResponder.isKind(of: UIViewController.self) {
                return nextResponder as? UIViewController
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
    
    
    func firstResponderNavigationController ()->(UINavigationController?) {
        var nextResponder : UIResponder? = self
        while nextResponder != nil {
            if let nextResponder = nextResponder , nextResponder.isKind(of: UINavigationController.self) {
                return nextResponder as? UINavigationController
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }

    func firstResponderOfKind<T: UIResponder>(_:T.Type) -> T?{
        var nextResponder : UIResponder? = self
        while nextResponder != nil {
            if let nextResponder = nextResponder , nextResponder.isKind(of: T.self) {
                return nextResponder as? T
            }
            nextResponder = nextResponder?.next
        }
        return nil
        
    }
    
}


