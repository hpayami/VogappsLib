//
//  PopupBase.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 03/11/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation

public protocol PopupDelegate : class {
    func didPresent(_ popup: Popup)
    func didDismiss(_ popup: Popup)
}

open class Popup : UIView {
    public enum PresentationStyle{
        case center
        case actionSheet(autoDimension:Bool)
    }
    
    public enum Priority {
        case normal
        case showImmediatelyOnTop
    }
    
    open var presentDuration : TimeInterval = 0.2
    open var dismissDuration : TimeInterval = 0.2
    open var presentationStyle: PresentationStyle = .center
    
    open var presentAnimation : PopupAnimation = .shrinkIn
    open var dismissAnimation : PopupAnimation = .growOut
    
    open var autoAdjustsForKeyboard : Bool = true
    open var backgroundPresentAnimation : PopupAnimation = .fadeIn
    open var backgroundDismissAnimation : PopupAnimation = .fadeOut
    
    open var priorty : Priority = .normal
    open var backgroundType: PopupBackground.BGType = .color(UIColor(rgba: "#000000CC"))
    open var minEdgesInContainer : UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
    open var dismissOnBackgroundTouch : Bool = true
    open var dismissOnContentTouch : Bool = false
    open var hidesStatusBarOnPresentation : Bool = false
    
    open weak var delegate: PopupDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override open var canBecomeFirstResponder : Bool {
        return true
    }
    
    @discardableResult
    open func present() -> Popup {
        return PopupQueue.defaultQueue.enqueuePopup(self)
    }
    
    ///Hook for background touch and content touch dismissals
    @discardableResult
    open func cancelPopup() -> Popup {
        return self.dismiss()
    }
    
    @discardableResult
    open func dismiss() -> Popup{
        return PopupQueue.defaultQueue.dismissPopup(self)
    }
    
    open func configure(){
        NotificationCenter.default.addObserver(self, selector: #selector(Popup.keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Popup.keyboardShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Popup.keyboardShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Popup.keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Popup.keyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardShow(_ notification: Notification){
        if !self.autoAdjustsForKeyboard {return}
        
        guard let keyboardFrame = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue,
            let animationDuration = ((notification as NSNotification).userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue,
            let animationCurve = ((notification as NSNotification).userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as AnyObject).uintValue else {return}
        
        let keyboardMinEdge = keyboardFrame.minY
        let keyboardMaxEdge = keyboardFrame.maxY
        let translationValue = (keyboardMaxEdge - keyboardMinEdge) / 2
        
        UIView.animate(withDuration: animationDuration, delay: 0, options:[UIView.AnimationOptions(rawValue: animationCurve), UIView.AnimationOptions.overrideInheritedCurve], animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -translationValue)
            }, completion: nil)
    }
    
    @objc func keyboardHide(_ notification: Notification){
        if !self.autoAdjustsForKeyboard {return}
        
        guard let animationDuration = ((notification as NSNotification).userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue,
            let animationCurve = ((notification as NSNotification).userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as AnyObject).uintValue else {return}
        
        UIView.animate(withDuration: animationDuration, delay: 0, options:[UIView.AnimationOptions(rawValue: animationCurve), UIView.AnimationOptions.overrideInheritedCurve], animations: {
            self.transform = CGAffineTransform.identity
            }, completion: nil)
    }
 
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
}

