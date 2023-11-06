//
//  PopupQueue.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 03/11/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit

private let _defaultQueue = PopupQueue()

open class PopupQueue {
    public static let defaultQueue: PopupQueue = _defaultQueue
    
    fileprivate var activePopups = [Popup]() {
        didSet{
            update()
        }
    }
    fileprivate var queue = [Popup]() {
        didSet{
            update()
        }
    }
    
    fileprivate func update(){
        if self.activePopups.count == 0 {
            if let popup = self.queue.first {
                self.activePopups.append(popup)
                self.removePopupFromQueue(popup)
                self._presentPopup(popup)
            }
        }
        else if self.activePopups.count > 0 {
            let priorityPopup = self.queue.first{$0.priorty == Popup.Priority.showImmediatelyOnTop}
            if let priorityPopup = priorityPopup {
                self.removePopupFromQueue(priorityPopup)
                self.activePopups.append(priorityPopup)
                self._presentPopup(priorityPopup)
            }
        }
    }
    
    open func dismissAllPopups(){
        self.activePopups.forEach{_dismissPopup($0)}
        self.queue = []
        self.activePopups = []
    }
    
    open func enqueuePopup(_ popup: Popup) -> Popup {
        self.queue.append(popup)
        return popup
    }
    
    open func dismissPopup(_ popup: Popup) -> Popup {
        self.removePopupFromActives(popup)
        self._dismissPopup(popup)
        return popup
    }
    
    fileprivate func _presentPopup(_ popup: Popup){
        let containerView = UIApplication.shared.keyWindow!
        let minEdges = popup.minEdgesInContainer
        let popupBG = PopupBackground(frame: CGRect.zero)
        popupBG.type = popup.backgroundType
        
        let bgPresentTransition = PopupAnimationFactory.animation(popup.backgroundPresentAnimation, duration: popup.presentDuration)
        
        containerView.addSubview(popupBG)
        popupBG.contentView?.layer.add(bgPresentTransition, forKey: "PresentAnimation")
        popupBG.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        popupBG.addSubview(popup)
        
        switch popup.presentationStyle{
        case .center:
            popup.autoPinEdge(toSuperviewEdge: .left, withInset: minEdges.left, relation: .greaterThanOrEqual)
            popup.autoPinEdge(toSuperviewEdge: .right, withInset: minEdges.right, relation: .greaterThanOrEqual)
            popup.autoPinEdge(toSuperviewEdge: .top, withInset: minEdges.top, relation: .greaterThanOrEqual)
            popup.autoPinEdge(toSuperviewEdge: .bottom, withInset: minEdges.bottom, relation: .greaterThanOrEqual)
            popup.autoCenterInSuperview()
        case .actionSheet(let autoDimension):
            if autoDimension{
                popup.autoPinEdge(toSuperviewEdge: .left, withInset: minEdges.left, relation: .greaterThanOrEqual)
                popup.autoPinEdge(toSuperviewEdge: .right, withInset: minEdges.right, relation: .greaterThanOrEqual)
                popup.autoPinEdge(toSuperviewEdge: .bottom, withInset: minEdges.bottom, relation: .equal)
                popup.autoAlignAxis(.vertical, toSameAxisOf: popup.superview!)
            }
            else {
                popup.autoPinEdge(toSuperviewEdge: .left, withInset: minEdges.left, relation: .equal)
                popup.autoPinEdge(toSuperviewEdge: .right, withInset: minEdges.right, relation: .equal)
                popup.autoPinEdge(toSuperviewEdge: .bottom, withInset: minEdges.bottom, relation: .equal)
            }
        }
        
        popup.layoutIfNeeded()
        let presentTransition = PopupAnimationFactory.animation(popup.presentAnimation, duration: popup.presentDuration)
        if popup.presentAnimation == .slideUp{
            (presentTransition as! CABasicAnimation).fromValue = popup.frame.size.height
            (presentTransition as! CABasicAnimation).toValue = 0
        }

        popup.animateTransition({
            popup.layer.add(presentTransition, forKey: nil)
            popup.becomeFirstResponder()
        },
        completion: {
            popup.becomeFirstResponder()
        })
        
        if popup.hidesStatusBarOnPresentation {
            UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.slide)
        }
        
        popup.delegate?.didPresent(popup)
    }
    
    fileprivate func _dismissPopup(_ popup: Popup){
        guard let popupBg = popup.superview as? PopupBackground else {return}
        
        let bgDismissTransition = PopupAnimationFactory.animation(popup.backgroundDismissAnimation, duration: popup.dismissDuration)
        let dismissTransition = PopupAnimationFactory.animation(popup.dismissAnimation, duration: popup.dismissDuration)
        
        if popup.dismissAnimation == .slideDown{
            (dismissTransition as! CABasicAnimation).toValue = popup.frame.height
        }
        
        if popup.backgroundDismissAnimation == .none{
            popup.removeFromSuperview(withTransition: dismissTransition){
                popupBg.removeFromSuperview()
            }
        }
        else {
            popup.removeFromSuperview(withTransition: dismissTransition)
            popupBg.contentView?.removeFromSuperview(withTransition: bgDismissTransition){
                popupBg.removeFromSuperview()
            }
        }
        
        if popup.hidesStatusBarOnPresentation {
            UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.slide)
        }
        popup.delegate?.didDismiss(popup)
    }
    
    
    fileprivate func removePopupFromQueue(_ popup: Popup){
        if let index = self.queue.firstIndex(where: {$0 === popup}) {
            self.queue.remove(at: index)
        }
    }
    
    fileprivate func removePopupFromActives(_ popup: Popup) {
        if let index = self.activePopups.firstIndex(where: {$0 === popup}) {
            self.activePopups.remove(at: index)
        }
    }
    
}


