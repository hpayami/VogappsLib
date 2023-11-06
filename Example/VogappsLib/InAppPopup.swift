//
//  InAppPopup.swift
//  Shilist
//
//  Created by Ogan on 13/09/15.
//  Copyright © 2015 Shilist. All rights reserved.
//

import UIKit
import VogappsLib

protocol InAppPopupDelegate : class {
    func inAppPopupDidPressNo(_ popup : InAppPopup)
    func inAppPopupDidPressYes(_ popup : InAppPopup)
}

class InAppPopup : ActionSheetPopup {
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    var inAppPopupDelegate : InAppPopupDelegate?
    
    static func create() -> Popup {
        return InAppPopup.fromNib()        
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.contentMode = .redraw
        
        noButton.addTarget(self, action: #selector(InAppPopup.noButtonAction), for: UIControl.Event.touchUpInside)
        yesButton.addTarget(self, action: #selector(InAppPopup.yesButtonAction), for: UIControl.Event.touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
        UIColor.white.setFill()
        bezierPath.fill()
    }
    
//    override func becomeFirstResponder() -> Bool {
//        return textField.becomeFirstResponder()
//    }
    
    @objc func noButtonAction(){
        self.dismiss()
        inAppPopupDelegate?.inAppPopupDidPressNo(self)
    }
    
    @objc func yesButtonAction(){
        self.dismiss()
        inAppPopupDelegate?.inAppPopupDidPressYes(self)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        let maskPath = UIBezierPath(roundedRect: self.headerView.bounds, byRoundingCorners: [UIRectCorner.topLeft , UIRectCorner.topRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.headerView.bounds
        maskLayer.path = maskPath.cgPath
        self.headerView.layer.mask = maskLayer
    }
}
