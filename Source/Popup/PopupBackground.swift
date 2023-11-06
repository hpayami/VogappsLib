//
//  PopupBackground.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 03/11/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation
import PureLayout

open class PopupBackground: UIView{
    
    public enum BGType {
        case none
        case color(UIColor)
        case blur(UIBlurEffect.Style)
    }
    
    open var contentView : UIView? {
        switch type{
        case .none:
            return nil
        case .color:
            return self.backgroundView
        case .blur:
            return self.effectsView
        }
    }
    
    fileprivate lazy var backgroundView : UIView = {
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.isHidden = true
        backgroundView.isUserInteractionEnabled = false
        self.addSubview(backgroundView)
        self.sendSubviewToBack(backgroundView)
        backgroundView.autoPinEdgesToSuperviewEdges()
        return backgroundView
    }()
    
    fileprivate lazy var effectsView : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView(frame: CGRect.zero)
        visualEffectView.isHidden = true
        visualEffectView.isUserInteractionEnabled = false
        self.addSubview(visualEffectView)
        self.sendSubviewToBack(visualEffectView)
        visualEffectView.autoPinEdgesToSuperviewEdges()
        return visualEffectView
    }()
    
    open var type : BGType = .color(UIColor(rgba: "#000000CC")) {
        didSet{
            update()
        }
    }
    
    func update(){
        switch type {
        case .none:
            self.backgroundView.isHidden = true
            self.effectsView.isHidden = true
        case .color(let color):
            self.backgroundView.isHidden = false
            self.effectsView.isHidden = true
            self.backgroundView.backgroundColor = color
        case .blur(let style):
            self.backgroundView.isHidden = true
            self.effectsView.isHidden = false
            self.effectsView.effect = UIBlurEffect(style: style)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let popup = self.subviews.last as? Popup else {return}
        guard let touchPoint = touches.first?.location(in: (popup as UIView)) else {return}
        
        let touchInsidePopup = (popup as UIView).point(inside: touchPoint, with: event)
        
        if(touchInsidePopup && popup.dismissOnContentTouch){
            popup.cancelPopup()
        }
        else if (!touchInsidePopup && popup.dismissOnBackgroundTouch){
            popup.cancelPopup()
        }
    }
    
}



